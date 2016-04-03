function plotHandleList = gui_slow_plot(axesHandleArray, mode, offsetPercent, pauseTime, XCell, YCell)
%GUI_SLOW_PLOT Plot slowly.
% 
% Plot vector XCell against vector YCell slowly.
% Plot vectors XCell{i} against vectors YCell{i} slowly.
% 
%
% Arguments:
% axesHandleArray:   A scalar or vector of handles to axes objects.
% 
% mode:             One of the following:
%                    'one axis': Everything will be plotted on one axis.
%                    'multiple axes': Each data line will be plotted on
%                    a different axis. In this mode, the number of elements
%                    in axesHandleArray, XCell and YCell must be equal.
% 
% pauseTime:        Time in seconds to pause between updates in plot.
%                   This, along with number of elements in the data lines,
%                   determine the time it takes for the function to execute.
% 
% offsetPercent:    Float specifying percentage of empty space between
%                   highest/lowest value and the boundary of axes. 
%                   To not resize axes, set offsetPercent to -1.
% 
% XCell:            A Cell array of vectors that act as the horizontal data
%                   on the plot. Can also be a single vector.
% 
% YCell:            A Cell array of vectors that act as the horizontal data
%                   on the plot. Can also be a single vector.
% 
% XCell and YCell must have the same length.
% Also, for each i, XCell{i} and YCell{i} must be of the same length.
% 
% Note: This function uses the "gui_resize_axis.m" function by
% Mohammadreza Khoshbin which can be downloaded from:
% https://github.com/k4vosh/gui_tools
% 
%  See also: PLOT, EZPLOT, PLOT3, TITLE, XLABEL, YLABEL, HOLD, LEGEND.
%  
% plotHandleList = GUI_SLOW_PLOT(axesHandleArray, mode, pauseTime, XCell, YCell)
% 
% Copyright (c) 2016 Mohammadreza Khoshbin

%#ok<*FORPF>

%% Validate input.
%Validate variable: axesHandleArray
validateattributes(axesHandleArray, {'numeric'}, {'vector'})
if ~all( ishandle(axesHandleArray))
    error('Some of graphic handles are invalid.')
end

%Validate variable: mode
if ~(strcmpi(mode, 'one axis')||strcmpi(mode, 'multiple axes'))
    error('Unexpected value for mode. Valid values are "one axis" and "multiple axes".')
end

%Validate variable: offsetPercent
validateattributes(offsetPercent, {'numeric'}, {'scalar', '<=', 20, '>=', -1})
if ~any( exist('gui_resize_axis') == [2 6]) %#ok<EXIST>
    offsetPercent = -1;
elseif offsetPercent == 0
    offsetPercent = -1;
end

%Validate variable: pauseTime
validateattributes(pauseTime, {'numeric'}, {'scalar'})

%Validate variable: XCell
validateattributes(XCell, {'cell', 'numeric'}, {'vector'})
if isnumeric(XCell) %There is only one vector.
    XCell = {XCell};
end
if ~all(cellfun(@isvector, XCell))
    error('At least one member of XCell is not a vector.')
end

%Validate variable: YCell
validateattributes(YCell, {'cell', 'numeric'}, {'vector'})
if isnumeric(YCell) %There is only one vector.
    YCell = {YCell};
end
if ~all(cellfun(@isvector, YCell))
    error('At least one member of YCell is not a vector.')
end

%Co-Validating variables: XCell, YCell
XCellLength = cellfun(@length, XCell);
YCellLength = cellfun(@length, YCell);
if ~all(XCellLength == YCellLength)
    error('At least two (Xn, Yn) vectors have different lengths.')
end
if numel(XCell) ~= numel(YCell)
    error('XCell and YCell have different lengths.')
end
dataLinesLength = XCellLength;
clear XCellLength YCellLength

%Co-Validating variables: mode, axesHandleArray
if strcmpi(mode, 'one axis') && numel(axesHandleArray) ~= 1
    error('gui_slow_plot is set to operate in "one axis" mode but axesHandleArray contains more than one element.')
elseif strcmpi(mode, 'multiple axes') && numel(axesHandleArray) ~= numel(XCell)
    error('gui_slow_plot is set to operate in "multiple axes" mode but axesHandleArray, XCell and YCell have different lengths.')
end
if strcmpi(mode, 'one axis') && numel(axesHandleArray) ~= 1
    %Everything will be plotted on a single axis.
    axesHandleArray = repmat(axesHandleArray, [numel(XCell),1]);
end

%% hold and resize all axes.
holdStatus = zeros(size(axesHandleArray));
for i=1:numel(axesHandleArray)
    %Record hold status and hold all axes.
    holdStatus(i) = ishold(axesHandleArray);
    hold(axesHandleArray(i), 'on');
    if offsetPercent ~= -1 %Resize all axes so their data fits.
        gui_resize_axis(axesHandleArray(i), offsetPercent, XCell{i}, YCell{i} )
    end
end

%% plot each dataLine in steps.
handleList{1, numel(XCell)} = [];
for i = 1:max(dataLinesLength)
    for cellId=1:numel(XCell)
        try
            handleList{cellId}(i) = plot(axesHandleArray(cellId), XCell{cellId}(i),YCell{cellId}(i));
        catch ME
            %Ignore badsubscript errors. They only mean that this is not
            %the biggest dataLine.
            if ~strcmp(ME.identifier, 'MATLAB:badsubscript')
                rethrow(ME)
            end
        end
    end
    pause(pauseTime);
end

%% delete old dataLines and plot them completely.
plotHandleList = -1 * ones(numel(XCell));
for cellId=1:numel(XCell)
    plotHandleList(cellId) = plot(axesHandleArray(cellId), XCell{cellId}, YCell{cellId});
    delete(handleList{cellId});
end
assert( all(plotHandleList ~= -1) )

%% reset hold status of axes.
for i=1:numel(axesHandleArray)  %All axes are held now,
    if ~holdStatus(i)           %but some were not held before the function.
        try
            set(axesHandleArray(i),'NextPlot','replace')
        catch
            if ~strcmp(ME.identifier, 'MATLAB:class:InvalidProperty')
                rethrow(ME)
            else
                hold(axesHandleArray(i), 'off');
            end
        end
    end
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