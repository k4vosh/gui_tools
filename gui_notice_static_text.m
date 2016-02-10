function gui_notice_static_text( stHandle, varargin )
%GUI_NOTICE_STATIC_TEXT Show a message in a GUI static text box, or turn it off.
% 
% Usage:
% GUI_NOTICE_STATIC_TEXT( handle, 'ON',  msg ) turns the static text box
%  visible and changes its "string" property to msg.
% 
% GUI_NOTICE_STATIC_TEXT( handle, 'OFF') turns the static text box invisible.
% 
% Note: The second argument can only be 'ON' or 'OFF'.
% 
% Examples:
% GUI_NOTICE_STATIC_TEXT( handle, 'ON',  'Hello World!' )
% GUI_NOTICE_STATIC_TEXT( handle.oneDofStatus_st, 'OFF')
% 
% GUI_NOTICE_STATIC_TEXT(stHandle, varargin)
% 
% Copyright (c) 2016 Mohammadreza Khoshbin


if nargin > 3
    error('Maximum number of arguments is 3.');
end
if strcmpi(varargin{1}, 'OFF')      %Make the static text box invisible.
    set(stHandle,'Visible','off')
    
elseif strcmpi(varargin{1}, 'ON')   %Make the static text box visible and
    try                             %show the desired message in it.
        msg = varargin{2};
    catch e
        if strcmp(e.identifier, 'MATLAB:badsubscript')
            error('The second argument is set to "ON", but a message text has not been provided.')
        else rethorw
        end
    end
    validateattributes(msg, {'char'}, {})
    set(stHandle,'String',msg)
    set(stHandle,'Visible','on')
    
else
    error ('The second argument must either be "ON" or "OFF"')
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The MIT License (MIT)
% 
% Copyright (c) 2016 Mohammadreza Khoshbin
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%