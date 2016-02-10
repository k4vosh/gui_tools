function gui_visible_invisible_element(type, elementHandleArray)
%GUI_VISIBLE_INVISIBLE_ELEMENT Make one or more GUI components visible or invisible.
% 
% Arguments:
%   type: 				A string. can be either 'VISIBLE' or 'INVISIBLE'.
%   elementHandleArray  One or an array of handles referring to component(s)
%                        of a GUI.
% 
% GUI_VISIBLE_INVISIBLE_ELEMENT(type, elementHandleArray)
% 
% Copyright (c) 2016 Mohammadreza Khoshbin

validateattributes(type, {'char'}, {})
validateattributes(elementHandleArray, {'numeric'}, {'vector'})
if ~all( ishandle(elementHandleArray))
    error('Some of graphic handles are invalid.')
end
switch lower(type)
    case 'visible'
        option = 'on';
    case 'invisible'
        option = 'off';        
    otherwise
        error('The first argument can only be "VISIBLE" or "INVISIBLE".')
end
for i=1:numel(elementHandleArray) %#ok<FORPF>
   set(elementHandleArray, 'visible', option); 
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