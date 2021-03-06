

addSNPs <-function(covstruc, SNPs){
  time<-proc.time()
 
  V_LD<-as.matrix(covstruc[[1]])
  S_LD<-as.matrix(covstruc[[2]])
  I_LD<-as.matrix(covstruc[[3]])
  
  SNPs<-data.frame(SNPs)
  beta_SNP<-SNPs[,grep("beta.",fixed=TRUE,colnames(SNPs))] 
  SE_SNP<-SNPs[,grep("se.",fixed=TRUE,colnames(SNPs))] 
    
  #set univariate intercepts to 1 if estimated below 1
  diag(I_LD)<-ifelse(diag(I_LD)<= 1, 1, diag(I_LD))
  
  #enter in k for number of phenotypes 
  k<-ncol(beta_SNP)
  
  #f = number of SNPs in dataset
  f=nrow(beta_SNP) 
  
  #make empty matrices for S_full
  S_Full_List<-vector(mode="list",length=f)
  V_Full_List<-vector(mode="list",length=f)
  
  #SNP variance (updated with 1KG phase 3 MAFs)
  varSNP=2*SNPs$MAF*(1-SNPs$MAF)  
  
  #small number because treating MAF as fixed
  varSNPSE2=(.00000001)^2
  
  #function to creat row/column names for S_full matrix
  write.names <- function(k, label = "V") {  
    varnames<-vector(mode="character",length=k+1)
    
    for (i in 1){
      varnames[1]<-c("SNP")}
    
    for (j in i:k) { 
      varnames[j+1]<-paste(label,j,sep="")}
    
    return(varnames)
  }
  
  S_names<-write.names(k=ncol(I_LD))

  for (i in 1:f) {
    
    #create empty vector for S_SNP
    S_SNP<-vector(mode="numeric",length=k+1)
  
    #enter SNP variance from reference panel as first observation
    S_SNP[1]<-varSNP[i]
    
    #enter SNP covariances (standardized beta * SNP variance from refference panel)
    for (p in 1:k) {
      S_SNP[p+1]<-varSNP[i]*beta_SNP[i,p]
    }
    
    #create shell of the full S (observed covariance) matrix
    S_Full<-diag(k+1)
    
    ##add the LD portion of the S matrix
    S_Full[(2:(k+1)),(2:(k+1))]<-S_LD
    
    ##add in observed SNP variances as first row/column
    S_Full[1:(k+1),1]<-S_SNP
    S_Full[1,1:(k+1)]<-t(S_SNP)
    
    ##name the columns/rows using the naming function defined outside of the loop
    rownames(S_Full) <- S_names
    colnames(S_Full) <- S_names
    
    ##smooth to near positive definite if either V or S are non-positive definite
    ks<-nrow(S_Full)
    smooth1<-ifelse(eigen(S_Full)$values[ks] <= 0, S_Full<-as.matrix((nearPD(S_Full, corr = FALSE))$mat), S_Full<-S_Full)
    
    ##store the full S to a list of S_full matrices
    S_Full_List[[i]]<-S_Full
    
    #create empty shell of V_SNP matrix
    V_SNP<-diag(k)
    
    ##pull the coordinates of the I_LD matrix to loop making the V_SNP matrix
    coords<-which(I_LD != 'NA', arr.ind= T)
    
    #loop to add in the GWAS SEs, correct them for univariate and bivariate intercepts, and multiply by SNP variance from reference panel
    for (p in 1:nrow(coords)) { 
      x<-coords[p,1]
      y<-coords[p,2]
      if (x != y) { 
        V_SNP[x,y]<-(SE_SNP[i,y]*SE_SNP[i,x]*I_LD[x,y]*I_LD[x,x]*I_LD[y,y]*varSNP[i]^2)}
      if (x == y) {
        V_SNP[x,x]<-(SE_SNP[i,x]*I_LD[x,x]*varSNP[i])^2
      }
    }
    
    ##create shell of full sampling covariance matrix
    V_Full<-diag(((k+1)*(k+2))/2)
    
    ##input the ld-score regression region of sampling covariance from ld-score regression SEs
    V_Full[(k+2):nrow(V_Full),(k+2):nrow(V_Full)]<-V_LD
    
    ##add in SE of SNP variance as first observation in sampling covariance matrix
    V_Full[1,1]<-varSNPSE2
    
    ##add in SNP region of sampling covariance matrix
    V_Full[2:(k+1),2:(k+1)]<-V_SNP
    
    k2<-nrow(V_Full)
    smooth2<-ifelse(eigen(V_Full)$values[k2] <= 0, V_Full<-as.matrix((nearPD(V_Full, corr = FALSE))$mat), V_Full<-V_Full)
    
    
    ##store the full V to a list of V_full matrices
    V_Full_List[[i]]<-V_Full
    
    print(i)
  }
  
  ##save the rsnumbers, MAF, A1/A2, and BP
  SNPs2<-SNPs[,1:6]
  
  return(Output <- list(V_Full=V_Full_List,S_Full=S_Full_List,RS=SNPs2))
  
}
