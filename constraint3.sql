/* Your compliance officer is adamant that certain safegaurds are installed in the database. 
Consider the following:

Worried about piracy and bandwidth consumption, they have also institued a hard cap of hard 
drive space on any givenmachine to 5TB. */

--ALTER TABLE Computers
--DROP CONSTRAINT Group3_Hdd5120GBLimit

ALTER TABLE Computers 
ADD CONSTRAINT Group3_Hdd5120GBLimit 
	CHECK (HardDriveCapacityinGB <= 5120)

/*INSERT Computers (ComputerTypeKey, BrandKey, ComputerStatusKey, PurchaseDate, PurchaseCost, MemoryCapacityInGB, 
	HardDriveCapacityinGB, VideoCardDescription, CPUTypeKey, CPUClockRateInGHZ) VALUES
	(1, 1, 0, '1/1/2017', 1999.99, 32, 6000, 'Nvidia 1080', 1, 3.5)*/
