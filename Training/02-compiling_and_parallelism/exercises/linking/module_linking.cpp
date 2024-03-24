#include <iostream>
#include <netcdf.h>

int main(int argc, char *argv[])
{
    std::cout << "Hello! This program is writing a NetCDF file!" << std::endl;

    int status = NC_NOERR;
    int ncid;
    int initialsz = 2048;
    size_t *bufrsize;

    *bufrsize = 1024;

    std::cout << "Creating a NetCDF output file..." << std::endl;
    status = nc__create("foo.nc", NC_NOCLOBBER, initialsz, bufrsize, &ncid);
        
    if (status != NC_NOERR) std::cout << "Error in creating the output file." << std::endl;
	
    status = nc_close(ncid);
    std::cout << "Deleting the NetCDF output file..." << std::endl;
    status = nc_delete("./foo.nc");
	
    if (status != NC_NOERR) std::cout << "Error in deleting the output file." << std::endl;
}
