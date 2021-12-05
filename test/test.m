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

% created for the purpose of signature matching
options.plot_fontsize=10;
options.export_report=0 % don't generate the report

% sort lists_action by the arrival times
[lists_action,idx]=sortrows(lists_action,1);
% sort lists_cmd accordingly
lists_cmd=lists_cmd(idx,:);

basic_info=sub_basic_info(lists_action,lists_cmd,options);

%% 4. Calculate the advanced metrics - LBA distribution

% lba_all.jpg:
% LBA versus time (arrival times),
% can observe the randomness/sequence of IO access.

% lba_size_freq_read/write/com.jpg:
% The size distribution with respect to (wrt) LBA range,
% ***************** this part was commented out for now ******************8
options.lba_size_set=50;
lba_stat_array=sub_lba_dist(lists_action,lists_cmd,options);

%% 5. Calculate the advanced metrics - Size distribution

% req_size_dist: row 8 col 1 is the number of requests with size 8
%                row 8 col 2 is the number of requests with size 8 andd
%                type is Write
%                row 8 col 2 is the number of requests with size 8 andd
%                type is Read

options.plot_figure=1;
req_size_record=sub_size_dist(lists_action,lists_cmd,options);

%% 6. Calculate the advanced metrics - Busy/Idle time

% this gives 2 values: total_busy_time and device_busy_percent 
time_record=sub_busy_time(lists_action,options);

% est_dev_queue_age, est_dev_idle_time, est_dev_acc_idle_time
idle_queue_record=sub_idle_queue(lists_action,options);

%% 7. Calculate the advanced metrics - average IOPS/throughput/request
% avg IOPS/throughput: used to observe the workload burst visually
% choose ∆t carefully. A too-large ∆t may smooth the curve but remove the IO burst. A practical choice is related to
% the average inter-arrival time, so ∆t may be a few times the average inter-arrival time, but not too much.

% average IOPS/throughput/request
options.time_interval=1;
average_record=sub_iops(lists_action,lists_cmd,options);

options.time_interval=6;
average_record= sub_iops(lists_action,lists_cmd,options);

%% 8. Calculate the advanced metrics - Spatial Locality:Logical Seek Distance

seek_dist_record=sub_seek_dist(lists_cmd,options);


