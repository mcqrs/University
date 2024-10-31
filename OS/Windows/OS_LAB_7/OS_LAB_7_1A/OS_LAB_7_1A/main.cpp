#include <windows.h>
#include <stdio.h>              // for printf

#define PAGELIMIT 8            // we'll ask for this many pages

LPTSTR lpNxtPage;               // address of the next page we'll ask for
DWORD dwPages = 0;              // count of pages we've gotten so far
DWORD dwPageSize;               // the page size on this computer

INT PageFaultExceptionFilter(DWORD dwCode)
{
    LPVOID lpvResult;

    // If the exception is not a page fault, exit.

    if (dwCode != EXCEPTION_ACCESS_VIOLATION)
    {
        printf("Exception code = %d\n", dwCode);
        return EXCEPTION_EXECUTE_HANDLER;
    }

    printf("Exception is a page fault\n");

    // If the reserved pages are used up, exit.

    if (dwPages >= PAGELIMIT)
    {
        printf("Exception: out of pages\n");
        return EXCEPTION_EXECUTE_HANDLER;
    }

    // Otherwise, commit another page.

    lpvResult = VirtualAlloc(
        (LPVOID)lpNxtPage, // next page to commit
        dwPageSize,         // page size, in bytes
        MEM_RESERVE | MEM_COMMIT,         // allocate a committed page
        PAGE_READWRITE);    // read/write access
    if (lpvResult == NULL)
    {
        printf("VirtualAlloc failed\n");
        return EXCEPTION_EXECUTE_HANDLER;
    }
    else {
        printf("Allocating another page.\n");
    }

    // Increment the page count, and advance lpNxtPage to the next page.

    dwPages++;
    lpNxtPage += dwPageSize;

    // Continue execution where the page fault occurred.

    return EXCEPTION_CONTINUE_EXECUTION;
}

int ErrorExit(LPTSTR oops)
{
    printf("Error! %s with error code of %ld\n", GetLastError());
    return (0);
}


VOID main(VOID)
{
    LPVOID lpvBase;               // base address of our test memory
    LPTSTR lpPtr;                 // generic character pointer
    BOOL bSuccess;                // flag
    //DWORD i;                      // generic counter
    SYSTEM_INFO sSysInfo;         // useful information about the system


    GetSystemInfo(&sSysInfo);     // populate the system information structure

    printf("This computer has a page size of %d.\n", sSysInfo.dwPageSize);
    printf("Processor type is %d\n", sSysInfo.dwProcessorType);
    printf("Number of processors is %d\n", sSysInfo.dwNumberOfProcessors);

    dwPageSize = sSysInfo.dwPageSize;

    printf("Exception is a page fault\n");

    // Reserve pages in the process's virtual address space.

    printf("Allocating another page.\n");

    lpvBase = VirtualAlloc(
        NULL,                 // system selects address
        PAGELIMIT * dwPageSize, // size of allocation
        MEM_RESERVE | MEM_COMMIT,          // allocate reserved pages
        PAGE_READWRITE);       // protection = no access
    if (lpvBase == NULL)
        printf("VirtualAlloc reserve failed");

    lpPtr = lpNxtPage = (LPTSTR)lpvBase;

    // Use structured exception handling when accessing the pages.
    // If a page fault occurs, the exception filter is executed to
    // commit another page from the reserved block of pages.

    WCHAR* char_ptr = static_cast<WCHAR*>(lpPtr);

    for (DWORD i = 0; i < PAGELIMIT * dwPageSize / 2; i++)
    {
        __try
        {
            // Write to memory.

            //lpPtr[i] = 'A';
            char_ptr[i] = 'a';
            //printf("Write to memory!\n");
        }

        // If there's a page fault, commit another page and try again.


        __except (PageFaultExceptionFilter(GetExceptionCode()))
        {

            // This is executed only if the filter function is unsuccessful
            // in committing the next page.

            ExitProcess(GetLastError());

        }

    }


    // Release the block of pages when you are finished using them.

    bSuccess = VirtualFree(
        lpvBase,            // base address of block
        dwPages * dwPageSize, // bytes of committed pages
        MEM_DECOMMIT | MEM_RELEASE); // decommit the pages

    printf("Release was %s.\n", bSuccess ? "unsuccessful" : "successful");
}
