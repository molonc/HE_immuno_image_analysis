

summary_stain_cells <- function(input_dir, tag){
  files <- list.files(path=input_dir, pattern = "*_celltype.csv$", recursive = F)
  print(input_dir)
  print(length(files))
  
  qc_ls <- list()
  count <- 0
  for(f in files){
    count <- count + 1
    tmp <- read.csv(paste0(input_dir,f),stringsAsFactors=F, check.names=F)
    qc_ls[[count]] <- tmp
  }
  
  qc_df <- do.call(rbind, qc_ls)
  print(dim(qc_df))
  print(colnames(qc_df))
  stat <- colSums(qc_df[,2:ncol(qc_df)])
  
  add_row <- nrow(qc_df)+1
  qc_df[add_row,"cell_name"] <- "summary"
  qc_df[add_row,"marker_cells"] <- stat["marker_cells"]
  qc_df[add_row,"unlabelled_cells"] <- stat["unlabelled_cells"]
  qc_df[add_row,"total_cells"] <- stat["total_cells"]
  
  print(qc_df[add_row,])
  colnames(qc_df)[which(colnames(qc_df)=="cell_name")] <- "image_block"
  write.csv(qc_df, file = paste0(input_dir,tag,'_summary.csv'),row.names = F, quote = F)
  return(qc_df)
}


stat_ls <- list()
markers <- c('CD3','CD4','CD8','CD57')
main_dir <- '/home/htran/storage/images_dataset/HE_10_33214/'
for(m in markers){
  input_dir = paste0(main_dir, m, '_tiles/CELL_TYPE/')
  cd <- summary_stain_cells(input_dir, m)
  rownames(cd) <- cd$image_block
  stat_ls[[m]] <- cd
  
}



stat_df <- dplyr::bind_rows(lapply(stat_ls, function(x) {
  x['summary',]
}))
stat_df$marker_type <- markers
stat_df$percent_marker <- round(stat_df$marker_cells/stat_df$total_cells * 100, digits=2)
stat_df <- stat_df[,!colnames(stat_df) %in% c("image_block")]

save_dir = '/home/htran/storage/images_dataset/HE_10_33214/macro/cell_type/'
write.csv(stat_df, file = paste0(save_dir,'summary_stain_counts.csv'), row.names=F, quote=F)

# View(stat_df)





# input_dir = '/home/htran/storage/images_dataset/HE_10_33214/CD3_tiles/CELL_TYPE/'
# cd3 <- summary_stain_cells(input_dir,'CD3')
# input_dir = '/home/htran/storage/images_dataset/HE_10_33214/CD4_tiles/CELL_TYPE/'
# cd4 <- summary_stain_cells(input_dir,'CD4')
# 
# input_dir = '/home/htran/storage/images_dataset/HE_10_33214/CD8_tiles/CELL_TYPE/'
# cd8 <- summary_stain_cells(input_dir,'CD8')
# 
# input_dir = '/home/htran/storage/images_dataset/HE_10_33214/CD57_tiles/CELL_TYPE/'
# cd57 <- summary_stain_cells(input_dir,'CD57')
# 
# rownames(cd4) <- cd4$image_block
# rownames(cd8) <- cd8$image_block
# rownames(cd57) <- cd57$image_block
# qc_df <- do.call(rbind, qc_ls)
# 
# stat_df <- cd3['summary',]
# stat_df <- rbind(stat_df, cd4['summary',])
# stat_df <- rbind(stat_df, cd8['summary',])
# stat_df <- rbind(stat_df, cd57['summary',])
# View(stat_df)
# stat_df$marker_type <- c("CD3","CD4","CD8","CD57")
# stat_df$percent_marker <- round(stat_df$marker_cells/stat_df$total_cells * 100, digits=2)
# stat_df <- stat_df[,!colnames(stat_df) %in% c("image_block")]
# save_dir = '/home/htran/storage/images_dataset/HE_10_33214/macro/cell_type/'
# write.csv(stat_df, file = paste0(save_dir,'summary_stain_counts.csv'), row.names=F, quote=F)
# write.csv(cd3, file = paste0(save_dir,'CD3_stain_counts.csv'), row.names=F, quote=F)
# View(cd3)
