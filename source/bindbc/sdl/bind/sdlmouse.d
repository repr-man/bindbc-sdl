
//          Copyright Michael D. Parker 2018.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sdl.bind.sdlmouse;

import bindbc.sdl.config;
import bindbc.sdl.bind.sdlstdinc : SDL_bool;
import bindbc.sdl.bind.sdlsurface : SDL_Surface;
import bindbc.sdl.bind.sdlvideo : SDL_Window;

struct SDL_Cursor;

enum SDL_SystemCursor {
    SDL_SYSTEM_CURSOR_ARROW,
    SDL_SYSTEM_CURSOR_IBEAM,
    SDL_SYSTEM_CURSOR_WAIT,
    SDL_SYSTEM_CURSOR_CROSSHAIR,
    SDL_SYSTEM_CURSOR_WAITARROW,
    SDL_SYSTEM_CURSOR_SIZENWSE,
    SDL_SYSTEM_CURSOR_SIZENESW,
    SDL_SYSTEM_CURSOR_SIZEWE,
    SDL_SYSTEM_CURSOR_SIZENS,
    SDL_SYSTEM_CURSOR_SIZEALL,
    SDL_SYSTEM_CURSOR_NO,
    SDL_SYSTEM_CURSOR_HAND,
    SDL_NUM_SYSTEM_CURSORS
}
mixin(expandEnum!SDL_SystemCursor);

enum SDL_BUTTON(ubyte x) = 1 << (x-1);

enum : ubyte {
    SDL_BUTTON_LEFT = 1,
    SDL_BUTTON_MIDDLE = 2,
    SDL_BUTTON_RIGHT = 3,
    SDL_BUTTON_X1 = 4,
    SDL_BUTTON_X2 = 5,
    SDL_BUTTON_LMASK = SDL_BUTTON!(SDL_BUTTON_LEFT),
    SDL_BUTTON_MMASK = SDL_BUTTON!(SDL_BUTTON_MIDDLE),
    SDL_BUTTON_RMASK = SDL_BUTTON!(SDL_BUTTON_RIGHT),
    SDL_BUTTON_X1MASK = SDL_BUTTON!(SDL_BUTTON_X1),
    SDL_BUTTON_X2MASK = SDL_BUTTON!(SDL_BUTTON_X2),
}

static if(sdlSupport >= SDLSupport.sdl204) {
    enum SDL_MouseWheelDirection {
        SDL_MOUSEWHEEL_NORMAL,
        SDL_MOUSEWHEEL_FLIPPED,
    }
    mixin(expandEnum!SDL_MouseWheelDirection);
}

static if(staticBinding) {
    extern(C) @nogc nothrow {
        SDL_Window* SDL_GetMouseFocus();
        uint SDL_GetMouseState(int* x, int* y);
        uint SDL_GetRelativeMouseState(int* x, int* y);
        void SDL_WarpMouseInWindow(SDL_Window* window, int x, int y);
        int SDL_SetRelativeMouseMode(SDL_bool enabled);
        SDL_bool SDL_GetRelativeMouseMode();
        SDL_Cursor* SDL_CreateCursor(const(ubyte)* data, const(ubyte)* mask, int w, int h, int hot_x, int hot_y);
        SDL_Cursor* SDL_CreateColorCursor(SDL_Surface* surface, int hot_x, int hot_y);
        SDL_Cursor* SDL_CreateSystemCursor(SDL_SystemCursor id);
        void SDL_SetCursor(SDL_Cursor* cursor);
        SDL_Cursor* SDL_GetCursor();
        SDL_Cursor* SDL_GetDefaultCursor();
        void SDL_FreeCursor(SDL_Cursor* cursor);
        int SDL_ShowCursor(int toggle);

        static if(sdlSupport >= SDLSupport.sdl204) {
            int SDL_CaptureMouse(SDL_bool enabled);
            uint SDL_GetGlobalMouseState(int* x, int* y);
            void SDL_WarpMouseGlobal(int x, int y);
        }
    }
}
else {
    extern(C) @nogc nothrow {
        alias pSDL_GetMouseFocus = SDL_Window* function();
        alias pSDL_GetMouseState = uint function(int* x, int* y);
        alias pSDL_GetRelativeMouseState = uint function(int* x, int* y);
        alias pSDL_WarpMouseInWindow = void function(SDL_Window* window, int x, int y);
        alias pSDL_SetRelativeMouseMode = int function(SDL_bool enabled);
        alias pSDL_GetRelativeMouseMode = SDL_bool function();
        alias pSDL_CreateCursor = SDL_Cursor* function(const(ubyte)* data, const(ubyte)* mask, int w, int h, int hot_x, int hot_y);
        alias pSDL_CreateColorCursor = SDL_Cursor* function(SDL_Surface* surface, int hot_x, int hot_y);
        alias pSDL_CreateSystemCursor = SDL_Cursor* function(SDL_SystemCursor id);
        alias pSDL_SetCursor = void function(SDL_Cursor* cursor);
        alias pSDL_GetCursor = SDL_Cursor* function();
        alias pSDL_GetDefaultCursor = SDL_Cursor* function();
        alias pSDL_FreeCursor = void function(SDL_Cursor* cursor);
        alias pSDL_ShowCursor = int function(int toggle);
    }

    __gshared {
        pSDL_GetMouseFocus SDL_GetMouseFocus;
        pSDL_GetMouseState SDL_GetMouseState;
        pSDL_GetRelativeMouseState SDL_GetRelativeMouseState;
        pSDL_WarpMouseInWindow SDL_WarpMouseInWindow;
        pSDL_SetRelativeMouseMode SDL_SetRelativeMouseMode;
        pSDL_GetRelativeMouseMode SDL_GetRelativeMouseMode;
        pSDL_CreateCursor SDL_CreateCursor;
        pSDL_CreateColorCursor SDL_CreateColorCursor;
        pSDL_CreateSystemCursor SDL_CreateSystemCursor;
        pSDL_SetCursor SDL_SetCursor;
        pSDL_GetCursor SDL_GetCursor;
        pSDL_GetDefaultCursor SDL_GetDefaultCursor;
        pSDL_FreeCursor SDL_FreeCursor;
        pSDL_ShowCursor SDL_ShowCursor;
    }

    static if(sdlSupport >= SDLSupport.sdl204) {
        extern(C) @nogc nothrow {
            alias pSDL_CaptureMouse = int function(SDL_bool enabled);
            alias pSDL_GetGlobalMouseState = uint function(int* x, int* y);
            alias pSDL_WarpMouseGlobal = void function(int x, int y);
        }

        __gshared {
            pSDL_CaptureMouse SDL_CaptureMouse;
            pSDL_GetGlobalMouseState SDL_GetGlobalMouseState;
            pSDL_WarpMouseGlobal SDL_WarpMouseGlobal;
        }
    }
}
