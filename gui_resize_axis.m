function gui_resize_axis(axisHandle, offsetPercent, xArray, yArray)
%GUI_RESIZE_AXIS Resize an axes component in a GUI axis.
% Note that this function only works on a GUI axis.
% Arguments:
%   axisHandle:         Handle to an axes component in a GUI axis.
%   offsetPercent:      Offset from minimum and maximum values, in percent.
%                        This is used to better display the plot.
%   xArray:             The data that is plotted on the x axis.
%   yArray:             The data that is plotted on the y axis.
% 
% GUI_RESIZE_AXIS(axisHandle, offsetPercent, xArray, yArray)
% 
% Copyright (c) 2016 Mohammadreza Khoshbin

if ~all( ishandle(axisHandle))
    error('Some of graphic handles are invalid.')
end

offset = offsetPercent / 100;

xlimit = get(axisHandle,'XLim');
xlimit(1) = min( xlimit(1), (1-offset)*min(xArray) );
xlimit(2) = max( xlimit(2), (1+offset)*max(xArray) );
if xlimit(1) == 0
    xlimit(1) = -1*offset*max(xArray);
end
xlim(axisHandle, xlimit);

ylimit = get(axisHandle,'YLim');
ylimit(1) = min( ylimit(1), (1-offset)*min(yArray) );
ylimit(2) = max( ylimit(2), (1+offset)*max(yArray) );
if ylimit(1) == 0
    ylimit(1) = -1*offset*max(yArray);
end
ylim(axisHandle, ylimit);
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