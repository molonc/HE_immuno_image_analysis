library(dplyr)
library(igraph)
library(parallel)

# BiocManager::install("GSReg")
# main_dir <- '/Users/hoatran/Documents/images_HE/images/4_S01/CD8_tiles/testing/'
# save_dir <- main_dir
# datatag <- '4_S01_CD8'

# main_datatag <- '5_06'  #1_10, 2_05, 3_08, 4_S01, 5_06, 6_10AS, HE_10_33214
base_dir <- '/home/htran/storage/images_dataset/'
# base_dir <- '/home/htran/storage/images_dataset/large_tissue/'
# base_dir <- '/home/htran/backup/home/htran/storage/images_dataset/large_tissue/'
# main_datatag <- '2_05'
# main_datatag <- '1_10'
main_datatag <- 'HE_10_33214'
scale_layout <- NULL
scale_img <- 300
draw_edges <- F
# marker <- 'CD57'
# marker <- 'CD8'
mk_ls <- c('CD57','CD8')
# mk_ls <- c('CD57')
for(marker in mk_ls){
  ##MacOS
  # main_dir <- paste0('/Users/hoatran/Documents/images_HE/images/',main_datatag,'/',marker,'_tiles/NUC/CELL_TYPE/')
  ## Linux
  main_dir <- paste0(base_dir,main_datatag,'/',marker,'_tiles/CELL_TYPE/')
  save_dir <- paste0('/home/htran/storage/images_dataset/large_tissue/summary_results/',main_datatag,'/')
  if(!file.exists(save_dir)){
    dir.create(save_dir)
  }
  # datatag <- paste0(main_datatag,'_',marker) #macos, linux large tissue
  datatag <- marker #linux, serie: HE_10_33214
  # datatag <- paste0(main_datatag,'-29602-A_',marker) ##linux, serie: 2_05
  results <- viz_cells_network(main_dir, save_dir, datatag, scale_layout, scale_img, draw_edges)
  
}


viz_cells_network <- function(main_dir, save_dir, datatag, 
                              scale_layout=NULL, scale_img=NULL, draw_edges=T){
  # cores_use <- 5
  # if(cores_use > detectCores()){
  #   cores_use < detectCores()
  # }
  noise_block <- 15
  if(grepl('*CD57*',datatag)){
    noise_block <- 30
  }else{
    noise_block <- 70
  }
  # tag <- paste0(datatag,'_80x.svs__1_') #2_05
  tag <- paste0(datatag,'.svs__1_') #'4_S01_CD8.svs__1_'
  nodes_fn_ls <- list.files(path = main_dir, pattern = "_nodes.csv$", recursive = F)
  
  file_not_empty <- function(f){
    return(file.info(f)$size>0) # & file.size(f)>0
  }  
  nodes_fn_ls <- nodes_fn_ls[sapply(paste0(main_dir,nodes_fn_ls), file_not_empty)]
  print(paste0('Nb blocks of image: ',length(nodes_fn_ls)))
  # yc <- c()
  # for(nodes_fn in nodes_fn_ls){
  #   # out <- mclapply(nodes_fn_ls, function(nodes_fn){
  #   main_fn <- gsub('_nodes.csv','',nodes_fn)
  #   # edges_fn <- paste0(main_fn,'_edges.csv')
  #   X <- gsub(paste0(tag,"([0-9]+)_[0-9]+$"), "\\1", main_fn)
  #   Y <- gsub(paste0(tag,"([0-9]+)_([0-9]+)$"), "\\2", main_fn)
  #   # yc <- c(yc, Y)
  #   # if(as.numeric(Y)==194350){
  #     nodes_df <- read.csv(paste0(main_dir,nodes_fn),check.names = F, stringsAsFactors = F)
  #     nodes_df$cell_type <- as.factor(nodes_df$cell_type)
  #     nb_cd57 <- sum(nodes_df$cell_type=='CD57')
  #     if(nb_cd57>=100){
  #       print(paste0('X: ',X, ' Y: ', Y, ' nb cd57: ', nb_cd57))
  #     }
  #     # print(summary(as.factor(nodes_df$cell_type)))
  #   # }
  # }  
  # min(as.numeric(yc))
  # max(as.numeric(yc))
  # sort(yc[1:5])
  
  excluded_border <- 5
  nodes_ls <- list()
  edges_ls <- list()
  for(nodes_fn in nodes_fn_ls){
    # out <- mclapply(nodes_fn_ls, function(nodes_fn){
    main_fn <- gsub('_nodes.csv','',nodes_fn)
    edges_fn <- paste0(main_fn,'_edges.csv')
    X <- gsub(paste0(tag,"([0-9]+)_[0-9]+$"), "\\1", main_fn)
    Y <- gsub(paste0(tag,"([0-9]+)_([0-9]+)$"), "\\2", main_fn)
    # print(paste0('Image tile info: X: ',X,'   Y:',Y))
    # cond <- !as.numeric(Y) %in% c(194350,191360)  # just in case of CD57 6_10AS, maybe background affect the computation
    nodes_fn <- paste0(main_dir,nodes_fn)
    # print(nodes_fn)
    nodes_df <- read.csv(nodes_fn, check.names = F, stringsAsFactors = F)
    # nodes_df <- read.csv(nodes_fn,check.names = F, stringsAsFactors = F)
    # print(dim(nodes_df))
    # colnames(nodes_df)
    # head(nodes_df)
    nodes_df$name <- paste0('N',nodes_df$cell_id,'_',X,'_',Y)
    # nodes_df <- nodes_df %>%
    #   dplyr::rename(x=centerX, y=centerY)
    # dim(nodes_df)
    nodes_df <- nodes_df %>%
      dplyr::filter(x < (max(x)-excluded_border)
                    & x > (min(x)+excluded_border) 
                    & y <(max(y)-excluded_border)
                    & x > (min(y)+excluded_border))
    nodes_df$x <- as.numeric(nodes_df$x) + as.numeric(X)
    nodes_df$y <- as.numeric(nodes_df$y) + as.numeric(Y)
    if(dim(nodes_df)[1]>0){
      t <- nrow(nodes_df[nodes_df$cell_type!='UNLABELLED',])/dim(nodes_df)[1]*100
      # if(t>10){
      #   print(paste0('exeption: fn: ',main_fn,' pct: ',t))
      # }
      if(t<noise_block){
        nodes_ls[[paste0(X,'_',Y)]] <- nodes_df  
        edges_fn <- paste0(main_dir,edges_fn)
        if(file.exists(edges_fn) & file.info(edges_fn)$size>0){ #& cond
          
          edges_df <- read.csv(edges_fn,check.names = F, stringsAsFactors = F)
          # print(dim(edges_df))
          # edges_df <- edges_df %>%
          #   dplyr::rename(from=from_cell_id,to=to_cell_id)
          if(dim(edges_df)[1]>0){
            edges_df$from <- paste0('N',edges_df$from,'_',X,'_',Y)
            edges_df$to <- paste0('N',edges_df$to,'_',X,'_',Y)
            # dim(edges_df)
            edges_df <- edges_df %>%
              dplyr::filter(from %in% nodes_df$name
                            & to %in% nodes_df$name)
            
            edges_ls[[paste0(X,'_',Y)]] <- edges_df
          }
          
          
        }
      }
      
    }
    
    
    
  }#, mc.cores = cores_use)
  # for(i in seq(1:length(out))){
  #   nodes_ls[[i]] <- out[[i]]$nodes_df
  #   edges_ls[[i]] <- out[[i]]$edges_df
  # }
  # 
  nodes_total <- dplyr::bind_rows(nodes_ls)
  edges_total <- dplyr::bind_rows(edges_ls)
  print(dim(nodes_total))
  print(dim(edges_total))
  # nodes_total_fn <- paste0(save_dir,datatag, "_nodes_total.csv")
  # edges_total_fn <- paste0(save_dir,datatag, "_edges_total.csv")
  # print(nodes_total_fn)
  # print(edges_total_fn)
  # write.csv(nodes_total, nodes_total_fn, quote = F, row.names = F)
  # write.csv(edges_total, edges_total_fn, quote = F, row.names = F)
  
  # nodes_total <- read.csv(paste0(save_dir,datatag, "_nodes_total.csv"), check.names = F, stringsAsFactors = F)
  # edges_total <- read.csv(paste0(save_dir,datatag, "_edges_total.csv"), check.names = F, stringsAsFactors = F)
  
  # dim(nodes_total)
  # print(summary(as.factor(nodes_total$cell_type)))
  # print(round(nrow(nodes_total[nodes_total$cell_type!='UNLABELLED',])/nrow(nodes_total)*100,2))
  res <- plot_igraph(edges_total, nodes_total, datatag, save_dir, scale_layout, scale_img, F, draw_edges)
  
  results <- list(edges_df=edges_total,nodes_df=nodes_total)
  # nb_contacts <- get_cells_contacts(res, obs_cell_type=NULL, contact_degrees=NULL)
  # res['nb_contacts'] <- nb_contacts
  return(results)
}

# plot_igraph(edges_total, nodes_total, datatag, save_dir, scale_layout, scale_img, F, draw_edges)


plot_igraph <- function(edges_df, nodes_df, datatag, save_dir, 
                        scale_layout=NULL, scale_img=NULL, extract_graph=F, draw_edges=T){
  library(dplyr)
  require(igraph)
  # Predefined color, size
  vcol <- c("UNLABELLED"="gray40","CD8"="green","CD57"="red")
  # sv <- c("UNLABELLED"=0.5,"CD8"=0.8,"CD57"=0.8)
  ## in case of 6_10AS, high number of CD8 and CD57
  sv <- c("UNLABELLED"=0.5,"CD8"=0.6,"CD57"=0.65)
  edge_col <- 'black'
  if(is.null(scale_layout)){
    scale_layout <- 1000  
    while(max(nodes_df$x)/scale_layout>=10){
      scale_layout <- scale_layout * 10
    }
    print(scale_layout)
  }
  if(is.null(scale_img)){
    scale_img <- 300
  }
  # Construct graph
  # nodes_df$id <- seq(1:nrow(nodes_df))
  # edges_df$id <- seq(1:nrow(edges_df))
  
  
  
  # edges list should contain from, to columns at the beginning of column list
  edges_df <- edges_df %>%
    select(from, to, everything())
  # nodes list should contain names, x, y columns at the beginning of column list
  nodes_df <- nodes_df %>%
    select(name,x, y, everything())
  
  print("Filter cells at boundary")
  g <- graph.data.frame(edges_df, directed = T, vertices = nodes_df)
  leaves <- V(g)[degree(g, mode="out")<=4]
  print(length(leaves))
  # leaves_ls <- c()
  leaves_ls <- parallel::mclapply(seq(1:length(leaves)), function(i){
    return(leaves[i]$name)
  }, mc.cores = 6) 
  # for(i in 1:length(leaves)){
  #   leaves_ls <- c(leaves_ls, leaves[i]$name)
  # }
  leaves_ls <- unlist(leaves_ls)
  print(leaves_ls[1])
  leave_marker <- nodes_df %>%
    dplyr::filter(cell_type != "UNLABELLED" & name %in% leaves_ls)
  print(dim(leave_marker))
  print(dim(nodes_df))
  nodes_df <- nodes_df %>%
    dplyr::filter(!name %in% leave_marker$name)
  print(dim(nodes_df))
  print(dim(edges_df))
  edges_df <- edges_df %>%
    dplyr::filter(!from %in% leave_marker$name &
                  !to %in% leave_marker$name)
  print(dim(edges_df))
  nodes_total_fn <- paste0(save_dir,datatag, "_nodes_total.csv")
  edges_total_fn <- paste0(save_dir,datatag, "_edges_total.csv")
  print(nodes_total_fn)
  print(edges_total_fn)
  write.csv(nodes_df, nodes_total_fn, quote = F, row.names = F)
  write.csv(edges_df, edges_total_fn, quote = F, row.names = F)
  print(summary(as.factor(nodes_df$cell_type)))
  print(round(nrow(nodes_df[nodes_df$cell_type!='UNLABELLED',])/nrow(nodes_df)*100,2))
  
  if(!draw_edges){
    edges_df <- edges_df[1:5,]  # still doesnt figure out how to completely remove edges, so draw it using white colors - background color
    edge_col <- 'white'
  }
  g <- graph.data.frame(edges_df, directed = F, vertices = nodes_df)
  res <- list(g=g, nodes_df=nodes_df, edges_df=edges_df, datatag=datatag)
  saveRDS(res, paste0(save_dir,datatag, "_graph.rds"))
  print(paste0('Save output as: ',save_dir,datatag, "_graph.png"))
  if(extract_graph){
    print("Skip the plot that take time")
    return(res)
  }


  nodes_cols <- vcol[nodes_df$cell_type]
  nodes_size <- sv[nodes_df$cell_type]


  # Build layout - a matrix
  lo1 <- nodes_df
  xmax <- (ceiling(max(lo1$x))+ 50)/scale_layout
  xmin <- (floor(min(lo1$x)) - 50)/scale_layout
  if(xmin<0){
    xmin=0
  }
  ymax <- (ceiling(max(lo1$y))+ 50)/scale_layout
  ymin <- (floor(min(lo1$y)) - 50)/scale_layout
  print(xmax)
  print(ymax)
  if(ymin<0){
    ymin=0
  }
  lo1$x <- lo1$x/scale_layout
  lo1$y <- lo1$y/scale_layout
  # rownames(lo1) <- paste0('Nuc',seq(1:nrow(lo1)))
  rownames(lo1) <- lo1$name
  lo1 <- lo1 %>%
    dplyr::select(x, y)
  # head(lo1)
  # lo <- layout.norm(as.matrix(node_df[,2:3]))


  png(paste0(save_dir,datatag, "_graph.png"), height = 2*ymax*scale_img, width=2*xmax*scale_img,res = 2*72)
  plot.igraph(g,  layout = as.matrix(lo1),
              xlim = c(xmin, xmax),
              ylim = c(ymin, ymax),
              rescale = FALSE,
              edge.curved = F,
              edge.color = edge_col,
              # edge.arrow.size = 10 / dpi,
              # edge.arrow.width = 0.5 / dpi,
              # vertex.label.dist = 50 / dpi,
              # vertex.label.degree = 90 / dpi,
              vertex.size = nodes_size,
              vertex.label=NA,
              # vertex.label.cex = 0.6,
              vertex.frame.color = NA,
              vertex.label.color = '#FFFF00',
              edge.color = '#000000',
              vertex.color=nodes_cols,
              # vertex.label.family = 'sans-serif',
              edge.width = 0.001
  )
  dev.off()


  return(res)
}

get_cells_contacts <- function(res, obs_cell_type=NULL, contact_degrees=NULL){
  ## Two rings
  # g <- make_ring(10)
  # plot.igraph(g)
  # bfs(make_ring(10) %du% make_ring(10), root=1, "out",
  #     order=TRUE, rank=TRUE, father=TRUE, pred=TRUE,
  #     succ=TRUE, dist=TRUE)
  if(is.null(obs_cell_type)){
    obs_cell_type <- 'CD8'
  }
  if(is.null(contact_degrees)){
    contact_degrees <- c(2,4,6)
  }
  nb_contacts_ls <- c()
  for(contact_degree in contact_degrees){
    f <- function(graph, data, extra) {
      # print(data)
      data['dist'] == contact_degree+1
    }
    nodes_df <- res$nodes_df
    # nodes_df <- nodes_df[1:5000,]
    nodes_df <- nodes_df %>%
      dplyr::filter(cell_type==obs_cell_type)
    # dim(nodes_df)
    rownames(nodes_df) <- nodes_df$name
    nodes_df$layer_contacts <- 0
    for(c in nodes_df$name){
      tmp <- bfs(res$g, root=c, callback=f)
      nodes_df[c,'layer_contacts'] <- sum(!is.na(tmp$order)) - 1 
    }
    nb_contacts_ls <- round(c(nb_contacts_ls, sum(nodes_df$layer_contacts)/nrow(nodes_df)),1)
  }
  names(nb_contacts_ls) <- paste0('layer_',contact_degrees)
  
  return(nb_contacts_ls)
  
}


bfs <- function(graph, start){
  #' Implementation of Breadth-First-Search (BFS) using adjacency matrix.
  #' This returns nothing (yet), it is meant to be a template for whatever you want to do with it,
  #' e.g. finding the shortest path in a unweighted graph.
  #' This has a runtime of O(|V|^2) (|V| = number of Nodes), for a faster implementation see @see ../fast/BFS.java (using adjacency Lists)
  #' @param graph an adjacency-matrix-representation of the graph where (x,y) is TRUE if the the there is an edge between nodes x and y.
  #' @param start the node to start from.
  #' @return Array array containing the shortest distances from the given start node to each other node
  
  # A Queue to manage the nodes that have yet to be visited, intialized with the start node
  queue = c(start)
  # A boolean array indicating whether we have already visited a node
  visited = rep(FALSE, nrow(graph))
  # (The start node is already visited)
  visited[start] = TRUE
  # Keeping the distances (might not be necessary depending on your use case)
  distances = rep(Inf, nrow(graph))  # Technically no need to set initial values since every node is visted exactly once
  # (the distance to the start node is 0)
  distances[start] = 0
  # While there are nodes left to visit...
  while(length(queue) > 0) {
    cat("Visited nodes: ", visited, "\n")
    cat("Distances: ", distances, "\n")
    node = queue[1] # get...
    queue = queue[-1] # ...and remove next node
    cat("Removing node ", node, " from the queue...", "\n")
    # ...for all neighboring nodes that haven't been visited yet....
    for(i in seq_along(graph[node,])) {
      if(graph[node,i] && !visited[i]){
        # Do whatever you want to do with the node here.
        # Visit it, set the distance and add it to the queue
        visited[i] = TRUE
        distances[i] = distances[node] + 1
        queue = c(queue, i)
        cat("Visiting node ", i, ", setting its distance to ", distances[i], " and adding it to the queue", "\n")
      }
    }
  }
  cat("No more nodes in the queue. Distances: ", distances, "\n")
  return (distances)
}


# input_dir <- '/Users/hoatran/Documents/images_HE/images/3_08/CD8_tiles/NUC/NUC_SEG/'
# input_dir <- '/Users/hoatran/Documents/images_HE/images/3_08/CD57_tiles/NUC/NUC_SEG/'
# fn <- read.table(paste0(input_dir,'fn.txt'), sep='\n', check.names = F)
# dim(fn)
# fn1 <- fn[1:round(nrow(fn)/2),, drop=F]
# dim(fn1)
# write.table(fn1, paste0(input_dir,'fn1.txt'), sep='\n', quote = F, row.names = F)
# series <- c('5_06', '3_08', '4_S01')
# for(s in series){
#   for(m in c('CD8','CD57')){
#     print(paste0('cp /Users/hoatran/Documents/images_HE/images/',s,'/',m,'_tiles/NUC/CELL_TYPE/',s,'_',m,'_graph.png .'))    
#     # print(paste0('cp /Users/hoatran/Documents/images_HE/images/',s,'/',m,'_tiles/NUC/CELL_TYPE/',s,'_',m,'_edges_total.csv .'))    
#     
#   }
#   
# }
# cp /Users/hoatran/Documents/images_HE/images/6_10AS/CD57_tiles/NUC/CELL_TYPE/6_10AS_CD57_nodes_total.csv .

# cp /Users/hoatran/Documents/images_HE/images/6_10AS/CD57_tiles/NUC/CELL_TYPE/6_10AS_CD57_edges_total.csv .
