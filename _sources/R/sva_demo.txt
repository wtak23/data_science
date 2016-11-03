R code from vignette source 'sva.Rnw'
"""""""""""""""""""""""""""""""""""""
The source R script available :download:`here <sva_demo.R>`

.. contents:: `Contents`
    :depth: 2
    :local:


.. code-block:: R

    ### R code from vignette source 'sva.Rnw'

    ##############################
    # Install required packages
    ##############################
    # source("https://bioconductor.org/biocLite.R")
    # biocLite('BiocStyle')
    # biocLite("bladderbatch")
    # install.packages('pamr')
    # biocLite("zebrafishRNASeq")
    ###################################################
    ### code chunk number 1: sva.Rnw:5-6
    ###################################################
    options(width=65)


    ###################################################
    ### code chunk number 2: style-Sweave
    ###################################################
    BiocStyle::latex()

::

    ## \RequirePackage{/home/takanori/R/x86_64-pc-linux-gnu-library/3.3/BiocStyle/resources/tex/Bioconductor}
    ## 
    ## \AtBeginDocument{\bibliographystyle{/home/takanori/R/x86_64-pc-linux-gnu-library/3.3/BiocStyle/resources/tex/unsrturl}}

.. code-block:: R

    ###################################################
    ### code chunk number 3: input
    ###################################################
    library(sva)

::

    ## Loading required package: mgcv

::

    ## Loading required package: nlme

::

    ## This is mgcv 1.8-14. For overview type 'help("mgcv-package")'.

::

    ## Loading required package: genefilter

.. code-block:: R

    library(bladderbatch)

::

    ## Loading required package: Biobase

::

    ## Loading required package: BiocGenerics

::

    ## Loading required package: parallel

::

    ## 
    ## Attaching package: 'BiocGenerics'

::

    ## The following objects are masked from 'package:parallel':
    ## 
    ##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ, clusterExport,
    ##     clusterMap, parApply, parCapply, parLapply, parLapplyLB, parRapply,
    ##     parSapply, parSapplyLB

::

    ## The following objects are masked from 'package:stats':
    ## 
    ##     IQR, mad, xtabs

::

    ## The following objects are masked from 'package:base':
    ## 
    ##     anyDuplicated, append, as.data.frame, cbind, colnames, do.call, duplicated,
    ##     eval, evalq, Filter, Find, get, grep, grepl, intersect, is.unsorted, lapply,
    ##     lengths, Map, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
    ##     pmin.int, Position, rank, rbind, Reduce, rownames, sapply, setdiff, sort,
    ##     table, tapply, union, unique, unsplit

::

    ## Welcome to Bioconductor
    ## 
    ##     Vignettes contain introductory material; view with 'browseVignettes()'. To
    ##     cite Bioconductor, see 'citation("Biobase")', and for packages
    ##     'citation("pkgname")'.

.. code-block:: R

    data(bladderdata)
    library(pamr)

::

    ## Loading required package: cluster

::

    ## Loading required package: survival

.. code-block:: R

    library(limma)

::

    ## 
    ## Attaching package: 'limma'

::

    ## The following object is masked from 'package:BiocGenerics':
    ## 
    ##     plotMA

.. code-block:: R

    ###################################################
    ### code chunk number 4: input
    ###################################################
    pheno = pData(bladderEset)


    ###################################################
    ### code chunk number 5: input
    ###################################################
    edata = exprs(bladderEset)


    ###################################################
    ### code chunk number 6: input
    ###################################################
    mod = model.matrix(~as.factor(cancer), data=pheno)


    ###################################################
    ### code chunk number 7: input
    ###################################################
    mod0 = model.matrix(~1,data=pheno)


    ###################################################
    ### code chunk number 8: input
    ###################################################
    n.sv = num.sv(edata,mod,method="leek")
    n.sv

::

    ## [1] 2

.. code-block:: R

    ###################################################
    ### code chunk number 9: input
    ###################################################
    svobj = sva(edata,mod,mod0,n.sv=n.sv)

::

    ## Number of significant surrogate variables is:  2 
    ## Iteration (out of 5 ):1  2  3  4  5

.. code-block:: R

    ###################################################
    ### code chunk number 10: input
    ###################################################
    pValues = f.pvalue(edata,mod,mod0)
    qValues = p.adjust(pValues,method="BH")


    ###################################################
    ### code chunk number 11: input
    ###################################################
    modSv = cbind(mod,svobj$sv)
    mod0Sv = cbind(mod0,svobj$sv)

    pValuesSv = f.pvalue(edata,modSv,mod0Sv)
    qValuesSv = p.adjust(pValuesSv,method="BH")


    ###################################################
    ### code chunk number 12: input
    ###################################################
    fit = lmFit(edata,modSv)


    ###################################################
    ### code chunk number 13: input
    ###################################################
    contrast.matrix <- cbind("C1"=c(-1,1,0,rep(0,svobj$n.sv)),"C2"=c(0,-1,1,rep(0,svobj$n.sv)),"C3"=c(-1,0,1,rep(0,svobj$n.sv)))
    fitContrasts = contrasts.fit(fit,contrast.matrix)


    ###################################################
    ### code chunk number 14: input
    ###################################################
    eb = eBayes(fitContrasts)
    topTableF(eb, adjust="BH")

::

    ##                    C1          C2        C3   AveExpr        F      P.Value    adj.P.Val
    ## 207783_x_at -13.45607  0.26592268 -13.19015 12.938786 8622.529 1.207531e-69 1.419929e-65
    ## 201492_s_at -13.27594  0.15357702 -13.12236 13.336090 8605.649 1.274450e-69 1.419929e-65
    ## 208834_x_at -12.76411  0.06134018 -12.70277 13.160201 6939.501 4.749368e-67 3.527673e-63
    ## 212869_x_at -13.77957  0.26008165 -13.51948 13.452076 6593.346 1.939773e-66 1.080599e-62
    ## 212284_x_at -13.59977  0.29135767 -13.30841 13.070844 5495.716 2.893287e-64 1.289423e-60
    ## 208825_x_at -12.70979  0.08250821 -12.62728 13.108072 5414.741 4.350100e-64 1.615555e-60
    ## 211445_x_at -10.15890 -0.06633356 -10.22523  9.853817 5256.114 9.845076e-64 3.133969e-60
    ## 213084_x_at -12.59345  0.03015520 -12.56329 13.046529 4790.107 1.260201e-62 3.510132e-59
    ## 201429_s_at -13.33686  0.28358293 -13.05328 12.941208 4464.995 8.675221e-62 2.147888e-58
    ## 214327_x_at -12.60146  0.20934783 -12.39211 11.832607 4312.087 2.257025e-61 5.029329e-58

.. code-block:: R

    ###################################################
    ### code chunk number 15: input
    ###################################################
    batch = pheno$batch


    ###################################################
    ### code chunk number 16: input
    ###################################################
    modcombat = model.matrix(~1, data=pheno)


    ###################################################
    ### code chunk number 17: input
    ###################################################
    combat_edata = ComBat(dat=edata, batch=batch, mod=modcombat, par.prior=TRUE, prior.plots=FALSE)

::

    ## Found 5 batches
    ## Adjusting for 0 covariate(s) or covariate level(s)
    ## Standardizing Data across genes
    ## Fitting L/S model and finding priors
    ## Finding parametric adjustments
    ## Adjusting the Data

.. code-block:: R

    ###################################################
    ### code chunk number 18: input
    ###################################################
    pValuesComBat = f.pvalue(combat_edata,mod,mod0)
    qValuesComBat = p.adjust(pValuesComBat,method="BH")


    ###################################################
    ### code chunk number 19: input
    ###################################################
    modBatch = model.matrix(~as.factor(cancer) + as.factor(batch),data=pheno)
    mod0Batch = model.matrix(~as.factor(batch),data=pheno)
    pValuesBatch = f.pvalue(edata,modBatch,mod0Batch)
    qValuesBatch = p.adjust(pValuesBatch,method="BH")


    ###################################################
    ### code chunk number 20: input2
    ###################################################
    n.sv = num.sv(edata,mod,vfilter=2000,method="leek")
    svobj = sva(edata,mod,mod0,n.sv=n.sv,vfilter=2000)

::

    ## Number of significant surrogate variables is:  2 
    ## Iteration (out of 5 ):1  2  3  4  5

.. code-block:: R

    ###################################################
    ### code chunk number 21: input
    ###################################################
    set.seed(12354)
    trainIndicator = sample(1:57,size=30,replace=F)
    testIndicator = (1:57)[-trainIndicator]

    trainData = edata[,trainIndicator]
    testData = edata[,testIndicator]

    trainPheno = pheno[trainIndicator,]
    testPheno = pheno[testIndicator,]


    ###################################################
    ### code chunk number 22: input
    ###################################################
    mydata = list(x=trainData,y=trainPheno$cancer)
    mytrain = pamr.train(mydata)

::

    ## 123456789101112131415161718192021222324252627282930

.. code-block:: R

    table(pamr.predict(mytrain,testData,threshold=2),testPheno$cancer)

::

    ##         
    ##          Biopsy Cancer Normal
    ##   Biopsy      3      1      4
    ##   Cancer      0     16      1
    ##   Normal      0      2      0

.. code-block:: R

    ###################################################
    ### code chunk number 23: input
    ###################################################
    trainMod = model.matrix(~cancer,data=trainPheno)
    trainMod0 = model.matrix(~1,data=trainPheno)
    trainSv = sva(trainData,trainMod,trainMod0)

::

    ## Number of significant surrogate variables is:  6 
    ## Iteration (out of 5 ):1  2  3  4  5

.. code-block:: R

    ###################################################
    ### code chunk number 24: input
    ###################################################
    fsvaobj = fsva(trainData,trainMod,trainSv,testData)
    mydataSv = list(x=fsvaobj$db,y=trainPheno$cancer)
    mytrainSv = pamr.train(mydataSv)

::

    ## 123456789101112131415161718192021222324252627282930

.. code-block:: R

    table(pamr.predict(mytrainSv,fsvaobj$new,threshold=1),testPheno$cancer)

::

    ##         
    ##          Biopsy Cancer Normal
    ##   Biopsy      3      0      1
    ##   Cancer      0     19      0
    ##   Normal      0      0      4

.. code-block:: R

    ###################################################
    ### code chunk number 25: input
    ###################################################
    library(zebrafishRNASeq)
    library(genefilter)
    data(zfGenes)
    filter = apply(zfGenes, 1, function(x) length(x[x>5])>=2)
    filtered = zfGenes[filter,]
    genes = rownames(filtered)[grep("^ENS", rownames(filtered))]
    controls = grepl("^ERCC", rownames(filtered))
    group = as.factor(rep(c("Ctl", "Trt"), each=3))
    dat0 = as.matrix(filtered)


    ###################################################
    ### code chunk number 26: input3
    ###################################################
    ## Set null and alternative models (ignore batch)
    mod1 = model.matrix(~group)
    mod0 = cbind(mod1[,1])

    svseq = svaseq(dat0,mod1,mod0,n.sv=1)$sv

::

    ## Number of significant surrogate variables is:  1 
    ## Iteration (out of 5 ):1  2  3  4  5

.. code-block:: R

    plot(svseq,pch=19,col="blue")

|image0|\ 

.. code-block:: R

    ###################################################
    ### code chunk number 27: input4
    ###################################################
    sup_svseq = svaseq(dat0,mod1,mod0,controls=controls,n.sv=1)$sv

::

    ## sva warning: controls provided so supervised sva is being performed.
    ## Number of significant surrogate variables is:  1

.. code-block:: R

    plot(sup_svseq, svseq,pch=19,col="blue")

|image1|\ 

.. |image0| image:: sva_demo_files/figure-html/unnamed-chunk-1-1.png
.. |image1| image:: sva_demo_files/figure-html/unnamed-chunk-1-2.png
