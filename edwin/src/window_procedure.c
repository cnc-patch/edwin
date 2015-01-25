#include <windows.h>
#include <Windowsx.h>
#include <stdbool.h>
#include "macros/patch.h"

SETDWORD(0x0047445C, _WindowProcedure);

LRESULT CALLBACK OriginalWindowProcedure(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    switch(uMsg)
    {
        case WM_MOUSEWHEEL:
        {
            short zDelta = GET_WHEEL_DELTA_WPARAM(wParam);
            if (zDelta > 0) //MouseWheel Up
            {
                return OriginalWindowProcedure(hwnd, WM_KEYDOWN, VK_RIGHT, 0);
                
            }
            else //MouseWheel Down
            {
                return OriginalWindowProcedure(hwnd, WM_KEYDOWN, VK_LEFT, 0);
            }
            break;
        }
        case WM_MBUTTONDOWN:
        {
            return OriginalWindowProcedure(hwnd, WM_KEYDOWN, VK_DOWN, 0);
            break;
        }
        case WM_MBUTTONUP:
        {
            return OriginalWindowProcedure(hwnd, WM_KEYUP, VK_DOWN, 0);
            break;
        }
    }
    return OriginalWindowProcedure(hwnd, uMsg, wParam, lParam);
}
