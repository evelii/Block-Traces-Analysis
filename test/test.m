%% 1. define the data source
filename = '/Users/Eve/Eve/2233/MBPAR/Data/blktrace.txt'; 

%% 2. calculate lists_action and lists_cmd
% i.e. calculate arrival times, complete times & LBA, Request size and R/W
blktrace_parser(filename);

%% 3. Calculate the basic metrics
% The following is based on batch_analysis in MBPAR
if size(lists_action,2)==7
    lists_action(:,1:2)=lists_action(:,6:7); % copied over col6 and col7 to col1 and col2
end

% options are not used, but created for the purpose of signature matching
options.plot_fontsize=10;

% sort lists_action by the arrival times
[lists_action,idx]=sortrows(lists_action,1);
% sort lists_cmd accordingly
lists_cmd=lists_cmd(idx,:);

basic_info=sub_basic_info(lists_action,lists_cmd,options);

%% 4. Calculate the advanced metrics

