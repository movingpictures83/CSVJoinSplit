dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

library(microbiome)
library(ggplot2)
#library(phyloseq)
library(ape)
library(psadd)
library(stringr)

input <- function(inputfile) {
  pfix = prefix()
  if (length(pfix) != 0) {
     prefix <- paste(pfix, "/", sep="")
  }

  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1]; 
   # Need to get the three files
#paste(pfix, toString(parameters["inputfile",2]), sep="")
   otu.path <<- paste(pfix, toString(parameters["otufile", 2]), sep="")
   tree.path <<- paste(pfix, toString(parameters["tree", 2]), sep="")
   map.path <<- paste(pfix, toString(parameters["mapping", 2]), sep="")
   #HMP <<- import_qiime(otu.path, map.path, tree.path, parseFunction = parse_taxonomy_qiime)
}
run <- function() {
   #samples.to.keep <<- sample_sums(HMP) >= 1000
   #HMP <<- prune_samples(samples.to.keep, HMP)
   #HMP <<- filter_taxa(HMP, function(x) sum(x >3) > (0.01*length(x)), TRUE)
   p0 <<- read_csv2phyloseq(otu.file=otu.path, taxonomy.file=tree.path, metadata.file=map.path)
}

output <- function(outputfile) {
  #pdf(paste(outputfile,"pdf",sep="."), width=8, height=8)#,  width = 10*300,        # 5 x 300 pixels
  #height = 10*300); #,)
  #print("Generating plot...")
  #y <- plot_bar(p0, x="Sample", fill=diffcol) + theme(legend.position="bottom", legend.title = element_text(size=2),
#legend.text = element_text(size=1)) + guides(col = guide_legend(ncol = 15))
  #y <- plot_bar(p0, x="Sample", fill=diffcol) + theme(legend.position="bottom", legend.title = element_text(size=3),
#legend.text = element_text(size=3)) + guides(fill = guide_legend(ncol = 12, keyheight=0.5, keywidth=0.5)) 
  #ggsave(paste(outputfile,"pdf",sep="."), y, width=10, dpi=300)
  #print(str(y))
  #print("Generating CSV...")
  #print(str(y$data))
  directoryflag <- 0

  if (dir.exists(paste(prefix(),"kingdom",sep="/"))) {
     directoryflag <- 1
     print(prefix())
     print(outputfile)
     outputfile = str_remove(outputfile, prefix())
     print(outputfile)
  }

  x <- t(otu_table(tax_glom(p0, taxrank = 'Kingdom', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Kingdom', NArm=T))[,"Kingdom"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"kingdom","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/kingdom/", outputfile, ".csv", sep=""))
  }

  x <-t(otu_table(tax_glom(p0, taxrank = 'Phylum', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Phylum', NArm=T))[,"Phylum"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"phylum","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/phylum/", outputfile, ".csv", sep=""))
  }

  x <- t(otu_table(tax_glom(p0, taxrank = 'Class', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Class', NArm=T))[,"Class"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"class","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/class/", outputfile, ".csv", sep=""))
  }

  x <- t(otu_table(tax_glom(p0, taxrank = 'Order', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Order', NArm=T))[,"Order"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"order","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/order/", outputfile, ".csv", sep=""))
  }
  
  x <- t(otu_table(tax_glom(p0, taxrank = 'Family', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Family', NArm=T))[,"Family"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"family","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/family/", outputfile, ".csv", sep=""))
  }

  x <- t(otu_table(tax_glom(p0, taxrank = 'Genus', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Genus', NArm=T))[,"Genus"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"genus","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/genus/", outputfile, ".csv", sep=""))
  }

  x <- t(otu_table(tax_glom(p0, taxrank = 'Species', NArm=T)))
  colnames(x) <- tax_table(tax_glom(p0, taxrank='Species', NArm=T))[,"Species"]
  if (directoryflag == 0) {
  write.csv(x, paste(outputfile,"species","csv",sep="."))
  }
  else {
  write.csv(x, paste(prefix(), "/species/", outputfile, ".csv", sep=""))
  }
}
#input("plugins/Bar/example/parameters.txt")
#run()
#output("plugins/Bar/example/yes.pdf")

