# devel-script for skylineR

# initialise object

skyTest <- new("skyline")

# import info, files, transitions

addFiles(skyTest, "/home/tom/Desktop/skylineR-files/rawfiles")
addInfo(skyTest, "/home/tom/Desktop/skylineR-files/runinfo.csv")
addTransitions(skyTest, "/home/tom/Desktop/skylineR-files/RP.csv")

skyTest@tempPath
