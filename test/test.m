%% 1. define the data source
filename = '/Users/Eve/Eve/2233/MBPAR/Data/blktrace.txt'; 

%% 2. calculate lists_action and lists_cmd
% i.e. calculate arrival times, complete times & LBA, Request size and R/W
blktrace_parser(filename);

%% 3. Calculate the basic metrics
% The following is based on batch_analysis
if size(lists_action,2)==7
    lists_action(:,1:2)=lists_action(:,6:7);
end