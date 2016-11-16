# devel-script for skylineR

# initialise object

skyTest <- new("skyline")

# import info, files, transitions

addFiles(skyTest, "/home/tom/Desktop/skylineR-files/rawfiles")
addInfo(skyTest, "/home/tom/Desktop/skylineR-files/runinfo.csv")
addTransitions(skyTest, "/home/tom/Desktop/skylineR-files/RP.csv")

skyTest@tempPath <- "C:/Users/Metabolomics/Desktop/skylineR-test/temp"
skyTest@SkylinePath <- "C:/Users/Metabolomics/Desktop/SkylineDailyRunner.exe"

load("/media/tom/TOMWILSON/skylineR-files/skyTest.RData")



skyTest <- object

load("/home/tom/Desktop/sky.RData")

sky@runinfo$name <- gsub(".RAW", "", sky@runinfo$name)
sky <- object

sky@calibrants <- data.frame()
calibrate(sky)


quantify(sky)

idk <- grep("Known",names(sky@quant))

known <- data.frame(sky@quant[,1],sky@quant[,idk])

