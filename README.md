4th seminar: PARALLEL PROCESSING IN BASH WITH LIMITED CONCURRENCY



OBJECTIVES OF TODAY'S SEMINAR
In this seminar, we aim to:
1.	Introduce the fundamentals of parallel processing in the context of Bash scripting on Linux systems.
2.	Explore methodologies and tools that facilitate the execution of parallel tasks with a focus on limited concurrency.
3.	Demonstrate practical examples of how to implement parallel processing in Bash, highlighting the benefits and potential pitfalls.
4.	Analyze the expected outcomes of parallel execution and discuss strategies for monitoring and controlling process execution.
By the end of this session, participants will have a solid understanding of how to leverage Bash scripting for parallel processing tasks, with a particular emphasis on maintaining system stability through limited concurrency. This knowledge will empower attendees to optimize their scripts for performance, enabling them to execute complex workflows efficiently and reliably.

4.1 INTRODUCTION

In the realm of computing, the efficiency and speed at which tasks are executed significantly enhance the performance of software applications. This is particularly crucial in an era dominated by multi-core CPU architectures, where the ability to perform multiple tasks concurrently can be leveraged to reduce execution times dramatically. Among the techniques employed to achieve such parallelism, the concepts of "forks" and "threads" stand out. These methodologies allow a program to distribute its workload across multiple execution paths, thus optimizing resource utilization and improving overall efficiency.
Parallel Processing in Bash
The Bash shell, a prevalent command interpreter on Linux systems, offers several utilities for facilitating parallel processing. 
 
This capability is invaluable for system administrators, developers, and researchers who seek to automate and expedite operations through scripts. By harnessing the power of parallel execution, tasks that would traditionally take considerable time to complete can be significantly accelerated.
Limited Concurrency: A Balanced Approach
However, with great power comes great responsibility. The unbridled execution of parallel processes can lead to system instability, resource contention, and, in extreme cases, the dreaded "fork bomb" scenario, where an uncontrollable proliferation of processes overwhelms the system's capacity to manage them. Hence, it is imperative to approach parallel processing in Bash with a strategy that balances efficiency with system stability.
Limited concurrency refers to the controlled execution of parallel processes, ensuring that only a predefined number of tasks run simultaneously. This approach not only mitigates the risk of overloading the system but also optimizes resource allocation, ensuring that each task has adequate access to CPU time and memory. In a Bash scripting context, this involves the use of specific constructs and utilities designed to manage parallel execution effectively.


4.2 BASICS: Creating and Managing Background Processes in Bash

INITIATING A BACKGROUND PROCESS
In the Bash shell, when you execute a command, the terminal waits for the command to complete before it accepts another. This sequential processing can be inefficient, especially for commands that take a significant amount of time to finish. To circumvent this, Bash allows you to run commands in the background, enabling you to continue working in the terminal without waiting for the previous command to complete.
Example: Running a Command in the Background
Consider the command sleep 10, which pauses execution for 10 seconds. Running this command in your terminal would typically block further inputs until the sleep completes. However, appending an ampersand (&) to the end of the command sends it to the background, allowing immediate continuation of other tasks.
sleep 10 &
Upon execution, this command returns control to the terminal while sleep 10 runs in the background. You are now free to execute subsequent commands without delay.

VIEWING BACKGROUND PROCESSES
While a background process does not occupy your terminal, it's essential to track which processes are running in the background. The jobs command provides a snapshot of all background tasks initiated from the current shell.
Example: Listing Background Processes
After initiating several sleep commands in the background:
sleep 130 &
sleep 100 &
sleep 70 &
You can view these background tasks by executing jobs, which might display:
[1]   Running                 sleep 130 &
[2]-  Running                 sleep 100 &
[3]+  Running                 sleep 70 &
This output lists each background job with an ID, its state (e.g., Running), and the command being executed. The job ID, enclosed in square brackets, is crucial for managing background processes.

MANAGING BACKGROUND PROCESSES
Background processes run independently of your terminal input, but you may need to interact with them, such as canceling a long-running task or bringing a process back to the foreground for input.
Bringing a Background Process to the Foreground
To interact with a background process directly, you can bring it to the foreground using the fg command followed by the job ID. For instance, to continue interacting with "sleep 100" (Job 2 in the example above):
fg 2
Executing this command brings Job 2 back to the foreground, allowing direct interaction through the terminal. The other background jobs continue to run independently.

ENHANCING PROCESS MANAGEMENT IN BASH
As we delve deeper into the realm of parallel processing in Bash, understanding how to find the process ID (PID) of a process, terminate a process, and adjust its priority becomes essential. These capabilities are crucial for fine-tuning system performance and managing resources efficiently. Let's explore these aspects to complement our foundational knowledge of managing background processes.
a.	Finding the PID of a Process
Each process running in the system is assigned a unique identifier known as the Process ID (PID). To manage processes effectively, especially when dealing with parallel execution, you may need to identify the PID of your background or foreground processes.
Using the ps Command
The ps command is a powerful utility for listing active processes. You can use it in combination with grep to find the PID of a specific process. For example, to find the PID of a sleep command, you would use:
ps aux | grep sleep
This command lists all processes, pipes the output to grep, which then filters for lines containing the word "sleep". The output includes the PID among other details, allowing you to identify the process you wish to manage.
b.	Killing a Process
There may be scenarios where a background process needs to be terminated before its completion. This is where the kill command comes into play, utilizing the PID to target the specific process for termination.
Example: Using the kill Command
Once you have the PID of the process, you can terminate it using:
kill [PID]
Replace [PID] with the actual process ID. If the process does not terminate because it's stuck or ignoring the signal, you can use kill -9 [PID], which sends a SIGKILL signal, forcing the process to terminate immediately.
c.	Adjusting Process Priority with nice and renice
In a multitasking environment, process priority determines how much CPU time processes receive. The nice command allows you to start a process with a defined niceness, which affects its priority. The renice command adjusts the niceness of an already running process.
Starting a Process with nice
To start a new process with a specific niceness (priority), use:
nice -n [niceness] [command]
The [niceness] values range from -20 (highest priority) to 19 (lowest priority). For example, to start a sleep command with low priority:
nice -n 10 sleep 120 &
Adjusting Priority with renice
To adjust the priority of an existing process, use renice:
renice [new_niceness] -p [PID]
For example, to decrease the priority of a process with PID 12345:
renice 10 -p 12345
This command changes the niceness of the process to 10, lowering its priority.

Summary and Practical Implications
Understanding how to identify PIDs, terminate processes, and adjust process priorities and, also how to run, manage, and foreground background processes are fundamental skills for managing parallel processes in Bash. These capabilities allow for more refined control over system resources, enabling you to optimize performance based on the specific needs of each task. By incorporating these techniques into your Bash scripting practices, you can enhance the efficiency and reliability of parallel processing tasks, ensuring that system resources are utilized effectively without compromising stability.
In subsequent sections, we will explore advanced techniques and tools for parallel processing, building on the basic understanding of background tasks to implement sophisticated concurrency control mechanisms. This will include methods for limiting the number of simultaneous processes to prevent system overload, thereby ensuring stable and efficient system performance.


4.3 ADVANCED: Implementing Limited Concurrency

Understanding Concurrency
Concurrency in programming refers to the capability of a system to run multiple processes or jobs simultaneously. This ability is essential for maximizing the efficiency of computing resources, especially in multi-core systems where tasks can be executed in parallel to significantly reduce overall processing time.
The Need for Limiting Concurrency
While parallel processing offers substantial time savings, indiscriminately running an excessive number of processes concurrently can lead to resource saturation, causing system instability or even crashes. This scenario underscores the importance of balancing parallelism with system resource limitations, thereby necessitating a controlled approach to concurrency. A system with limited concurrency is designed to run a specific number of processes in parallel, ensuring that system resources are optimally utilized without overloading.
Monitoring the Job Pool
To implement limited concurrency, it is crucial to monitor the current pool of background jobs, ensuring that the number of concurrently running processes does not exceed a predefined limit. The jobs command, as explored in the Basics section, provides a list of currently running background jobs. 
echo $(jobs | wc -l)
Coupled with wc -l, we can programmatically determine the number of active background jobs:
CURRENT_POOL_SIZE=$(jobs | wc -l)
This command counts the number of lines in the output of jobs, effectively representing the current size of the job pool.

Implementing Limited Concurrency Logic
Given this capability to monitor the job pool size, we can construct a loop that processes a list of tasks while adhering to a maximum concurrency limit. This ensures that the system runs a manageable number of parallel jobs, waiting to spawn new ones only when the active job count falls below the threshold.
Pseudocode for Limited Concurrency
MAX_POOL_SIZE=10
JOB_LIST=job-list.txt

while read line from $JOB_LIST; do
  while [ $(jobs | wc -l) -ge $MAX_POOL_SIZE ]; do
    # This loop checks if the current number of background jobs
    # is greater than or equal to the maximum allowed.
    # It waits until a job completes before continuing.
    sleep 1 # A short sleep to prevent aggressive CPU usage
  done

  # Outside the loop, we have room to start a new background job.
  process_job "$line" &
  # It's important to check the current pool size again before the next iteration.
done < $JOB_LIST

# Wait for all background jobs to finish before exiting the script
wait


In this pseudocode, process_job.xxx is a placeholder for a function that you would define to handle each job. This structure ensures that the script reads each task from job-list.txt, processes it in the background, and maintains the number of concurrent jobs at or below MAX_POOL_SIZE.
Expected Outcome
This approach to limited concurrency in Bash scripting provides a robust mechanism for managing parallel processes. By dynamically adjusting the load on the system, it significantly reduces the risk of overloading while optimizing the utilization of system resources. The implementation ensures that long-running tasks are executed efficiently, with the system's stability maintained throughout the operation.
Practical Implications
Adopting a strategy of limited concurrency in Bash scripts is invaluable for a wide range of applications, from data processing and batch file operations to automated system maintenance tasks. It allows for the leveraging of parallel processing advantages—such as reduced execution times and increased throughput—while ensuring the system remains responsive and stable. This method is particularly beneficial in scenarios where resources are limited and managing system load is critical for performance and reliability.

A SIMPLE EXAMPLE: NETWORK REACHABILITY CHECK

Scenario Overview
Network administrators often face the task of assessing the quality and reliability of their network connections to various remote servers. This assessment typically involves sending a series of ping requests to each server to evaluate network reachability. In this example, we demonstrate a practical application of parallel processing in Bash to perform network reachability checks on a list of remote server endpoints efficiently.
The Task
Given a list of server endpoints along with the number of ping requests to be sent to each, our goal is to execute these ping operations in parallel, adhering to a limit on the number of concurrent operations to prevent overloading the system resources.
Input Format
Our input, represented in a file named job-list.txt, contains server hostnames followed by the number of pings to send to each, in the format {hostname} {number of pings}. For instance:
google.com 10
facebook.com 3
youtube.com 5
linkedin.com 20
twitter.com 8
sop.ase.ro 10
github.com 3
ubuntu.com 5
redhat.com 6
kubernetes.io 20

Implementing the Solution
We will employ a Bash script to read each line from job-list.txt, parsing the hostname and the number of pings, and then executing the ping command in the background within the constraints of limited concurrency.
Command Explanation
•	ping $1 -c $2 -q: This command pings the hostname ($1), with $2 specifying the number of ping requests. The -q flag is used to output only the summary of the ping operation, which is essential for our purpose of evaluating network reachability.
Sample Output
For a single operation such as ping -c 10 -q google.com, the expected output might look like:
PING google.com (142.251.12.100): 56 data bytes
--- google.com ping statistics ---
10 packets transmitted, 10 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 59.528/66.335/68.198/2.599 ms
This summary provides crucial metrics such as packet loss and round-trip time, which are indicative of the network's performance to that endpoint.
PINGparallel1NOT.sh or PINGparallel2NOT.sh

4.5 SCRIPT EXAMPLE Without Parallel Capability

In the context of our seminar on parallel processing with Bash, it's instructive to examine a script designed to perform network reachability checks without parallel execution capabilities. This will serve as a foundation for understanding the enhancements that parallel processing brings. The script, named PINGparallel1NOT.sh (or PINGparallel2NOT.sh), offers a sequential approach to pinging a list of hostnames specified in a job-list.txt file.
Overview of the Script
This Bash script demonstrates a straightforward method for iterating over a list of server endpoints and the number of pings to send to each, as specified in job-list.txt. The script performs the following operations in sequence:
1.	File Existence Check: Initially, the script verifies the presence of the job-list.txt file. If the file is not found, it exits with an error message.
2.	Line-by-Line File Reading: The script reads the job-list.txt file line by line, processing each line to extract the hostname and ping count.
3.	Hostname and Ping Count Extraction: For each line, the script uses Bash's read command with a here-string to split the line into an array, separating the hostname from the ping count.
4.	Ping Execution: For each hostname, the script executes the ping command using the specified number of pings (-c option) and quiet mode (-q option) to limit the output to the summary.
5.	Result Handling: Depending on the success or failure of the ping command (indicated by its exit status), the script prints either a success message with the ping results or a failure message.
6.	Completion Message: Finally, the script prints a message indicating the completion of the network reachability summary.
Script Content:
#!/bin/bash

# This line checks if the file 'job-list.txt' exists in the current directory.
if [ ! -f "job-list.txt" ]; then
    # If the file does not exist, print an error message and exit the script.
    echo "Error: File job-list.txt does not exist."
    exit 1
fi

# Read the file 'job-list.txt' line by line.
while IFS= read -r line; do
    # The '<<<' is called a here-string. It feeds the string into 'read' as standard input.
    # This line takes the current line of text and splits it into an array based on whitespace.
    # ADDR[0] will have the hostname, and ADDR[1] will have the number of pings.
    read -ra ADDR <<< "$line"
    
    # Assign the first part (hostname) to the variable HOSTNAME.
    HOSTNAME=${ADDR[0]}
    # Assign the second part (number of pings) to the variable PING_COUNT.
    PING_COUNT=${ADDR[1]}
    
    # Check if PING_COUNT is a number.
    if ! [[ $PING_COUNT =~ ^[0-9]+$ ]]; then
        # If PING_COUNT is not a number, print an error message and skip to the next line.
        echo "Error: Ping count for $HOSTNAME is not a valid number."
        continue
    fi
    
    # Print the operation that's going to be performed.
    echo "Pinging $HOSTNAME $PING_COUNT times."

    # Execute the ping command with the specified count and quiet mode.
    # Capture the output of the ping command into the variable PING_RESULT.
    PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME")

    # Check the exit status of the last command (ping in this case).
    if [ $? -eq 0 ]; then
        # If the exit status is 0 (success), print the successful ping message and its result.
        echo "Ping to $HOSTNAME was successful:"
        echo "$PING_RESULT"
        echo "--------------------------------------"
    else
        # If the ping failed, print a failure message.
        echo "Ping to $HOSTNAME failed."
    fi

# This done statement signifies the end of the while loop.
# It takes the 'job-list.txt' file as input to the while loop.
done < "job-list.txt"

# Print a final message indicating the script has finished running.
echo "Network reachability summary completed."

Expected Output
The script outputs the operation being performed for each hostname, followed by the result of the ping operation. Success messages include the summary of ping statistics, while failure messages indicate an inability to reach the hostname.
Analysis and Implications
While the script effectively accomplishes the task of checking network reachability, its sequential execution model introduces significant time inefficiencies, especially when dealing with a large number of hostnames or high ping counts. Each ping command must complete before the next begins, resulting in cumulative wait times that could be reduced through parallel processing.
In contrast, a parallel processing approach would allow multiple ping commands to run concurrently, significantly reducing the total execution time for the script while ensuring system stability through controlled concurrency. This comparison underscores the value of parallel processing techniques in optimizing operational efficiency in Bash scripts.
In the next sections, we will explore how to enhance this script with parallel processing capabilities, leveraging the techniques discussed earlier in the seminar to improve performance and efficiency.


4.6 SCRIPT EXAMPLE with parallel capability:

In this section, we explore a Bash script designed to enhance network reachability checks through parallel processing, while maintaining a controlled environment to prevent overloading system resources. This script, a progression from the sequential approach previously discussed, demonstrates the application of limited concurrency in executing ping commands across a list of server endpoints.

Script Overview
The script, referred to as PINGparallel3.sh (to PINGparallel6.sh with minor variations), introduces a methodical approach to parallel execution within Bash. It utilizes a set of defined variables and custom functions to read server endpoints from (the same as above) job-list.txt file, executing ping commands in parallel without exceeding a specified concurrency limit.
Key Components of the Script
•	MAX_POOL_SIZE: Specifies the maximum number of concurrent background jobs allowed.
•	JOB_LIST: Path to the text file containing the tasks (server endpoints and ping counts).
•	OUTPUT: File path where the output of the process_job() function is written.
•	CURRENT_POOL_SIZE: Monitors the number of currently running jobs, aiding in concurrency control.
Script Functionality
1.	Concurrency Control: The script begins by setting a concurrency limit (MAX_POOL_SIZE) to ensure system stability. It prevents the script from initiating more background jobs than the system can handle efficiently.
2.	Job Processing: It reads each line from JOB_LIST, which contains a hostname and the number of pings to be sent. For each line, a custom function process_job() is called to execute the ping operation in the background.
3.	Monitoring and Waiting: A critical aspect of the script is its ability to monitor the current number of background jobs (CURRENT_POOL_SIZE) and wait if this number reaches the MAX_POOL_SIZE. This mechanism ensures that the script does not overwhelm the system by exceeding the allowed number of concurrent jobs.
4.	Output Handling: The results of each ping operation are appended to an output file (OUTPUT), providing a consolidated view of the network reachability checks.
Script Content:
#!/bin/bash

#This is a simple example of parallel processing in Bash with limited number of concurrent forks.
#This allows us to run multiple time consuming tasks in parallel, yet avoid forkbombs by executing too many taks at once.

### Variable definition

#| Variable | Description |
#|---|---|
#| MAX_POOL_SIZE | Defines how many maximum number of background jobs we need to be running at a given time. |
#| JOB_LIST | Holds the path to a text file which contains the tasks we need to process. |
#| OUTPUT | Holds the file path to the output file, which will be written by the "process_job()" function |
#| CURRENT_POOL_SIZE | Keep track how many jobs are currently running during the program runtime. This is used to decide whether to stop creating new background jobs and wait for the running jobs to finish. |


# This is the concurrency limit
MAX_POOL_SIZE=5

# Jobs will be loaded from this file
JOB_LIST=job-list.txt

# Output file
OUTPUT=output.txt

# This is used within the program. Do not change.
CURRENT_POOL_SIZE=0

# This is a just a function to print the output as a log with timestamp
_log() {
        echo " $(date +'[%F %T]') - $1"
}

# This is the custom function to process each job read from the file
process_job() {
  # customize your job function as required
  # in our example, we just "ping" each hostname read from the file
  ping $1 -c $2 -q | tee -a $OUTPUT
}


# ------ This is the main program code --------

# Starting the timer
T1=$(date +%s)

# Reading the $JOB_LIST file, line by line
while IFS= read -r line; do
  
  # This is the blocking loop where it makes the program to wait if the job pool is full
  while [ $CURRENT_POOL_SIZE -ge $MAX_POOL_SIZE ]; do
    _log "Pool is full. waiting for jobs to exit..."
    sleep 1
    
    # The above "echo" and "sleep" is for demo purposes only.
    # In a real usecase, remove those two and keep only the following line
    # It will drastically increase the performance of the script
    CURRENT_POOL_SIZE=$(jobs | wc -l)
  done
  
  
  # This is a custom function to process each job read from the file
  # It calls the custom function with each line read by the $JOB_LIST and send it to background for processing
  _log "Starting job $line"  
  process_job $line &
  
  # When a new job is created, the program updates the $CURRENT_POOL_SIZE variable before next iteration
  CURRENT_POOL_SIZE=$(jobs | wc -l)
  _log "Current pool size = $CURRENT_POOL_SIZE"
  
  
done < $JOB_LIST # this is where we feed the $JOB_LIST file for the read operation

# wait for all background jobs (forks) to exit before exiting the parent process
wait

# Ending the timer
T2=$(date +%s)

_log "All jobs completed in $((T2-T1)) seconds. Parent process exiting."
_log "Final output is written in $OUTPUT"
exit 0

Expected Outcome
Upon execution, this script parallelizes the ping operations, significantly reducing the overall time required to complete the reachability checks across multiple servers. The output file (OUTPUT) contains the consolidated results of these operations, including statistics such as packet loss and round-trip times, which are crucial for assessing network quality.
Practical Implications
The implementation of parallel processing with limited concurrency in Bash scripts exemplifies an efficient approach to handling multiple, time-consuming tasks simultaneously. This technique not only optimizes system resource usage but also accelerates the execution of batch operations, which is invaluable in network administration and similar domains. By applying the concepts demonstrated in this script, users can adapt and extend parallel processing techniques to a wide array of tasks, further enhancing operational efficiency and system performance.




END NOTES:
CONCLUSIONS
Throughout this seminar series, we have embarked on a comprehensive exploration of parallel processing in Bash, emphasizing the strategic advantage of limited concurrency. This journey has taken us from the foundational principles of executing background processes in Bash to sophisticated techniques for managing parallel tasks efficiently. Our exploration included detailed script examples, demonstrating both sequential and parallel processing approaches for network reachability checks, providing a practical lens through which to understand the theoretical concepts discussed.
The critical takeaway from this seminar is the tangible benefits of parallel processing in optimizing task execution times and enhancing system resource utilization. By incorporating limited concurrency, we mitigate the risks associated with resource overloads, ensuring system stability while maximizing efficiency. This balance is crucial in a multi-core computing environment, where the ability to execute multiple operations simultaneously can dramatically reduce the overall processing time of batch tasks.
PROJECTS TO DO
To reinforce the concepts covered in this seminar and enhance your proficiency in Bash scripting with parallel processing, consider undertaking the following projects:
1.	Network Health Dashboard: Expand the network reachability script to continuously monitor a list of servers, generating a real-time dashboard that visualizes network health metrics. Incorporate features such as alerting for unreachable servers and historical data analysis.
2.	Parallel File Processing: Develop a script to process a large set of files (e.g., log files, data dumps) in parallel. Implement functionality to analyze file content, summarizing key metrics or extracting specific information, while adhering to concurrency limits.
3.	Automated System Updates: Create a Bash script that performs system updates across multiple servers simultaneously. The script should ensure that the update process does not overload any single server, maintaining service availability.
4.	Web Scraper: Implement a parallel web scraper that can fetch data from multiple URLs concurrently. Incorporate error handling and ensure the scraper respects the concurrency limit to avoid overwhelming web servers or being blocked.
These projects are designed to challenge your understanding and application of parallel processing concepts in real-world scenarios. They will help solidify your knowledge while providing practical skills that can be applied in various domains.
FINAL ADVICE
To further enrich your understanding of parallel processing in Bash, we strongly recommend reviewing the PowerPoint presentation associated with this seminar series. The presentation contains valuable notes and insights that complement the information discussed in these sessions. It serves as an excellent resource for revisiting key concepts and examples at your own pace.
As you continue to explore the vast potential of Bash scripting and parallel processing, remember that practice is paramount. Experimenting with different scenarios and configurations will not only deepen your comprehension but also unveil innovative ways to leverage these powerful techniques in your projects and daily tasks.
In conclusion, the mastery of parallel processing in Bash scripting opens up a realm of possibilities for optimizing workflows and achieving remarkable efficiencies. We encourage you to continue learning, experimenting, and applying these concepts to harness the full potential of your computing resources.
