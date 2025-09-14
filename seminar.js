// Web Seminar 01 - Parallel Processing Demo

export class ParallelDemo {
    constructor() {
        this.results = [];
    }

    // Simulate a time-consuming task
    async simulateTask(taskName, duration) {
        return new Promise((resolve) => {
            setTimeout(() => {
                const result = `Task ${taskName} completed in ${duration}ms`;
                this.results.push(result);
                resolve(result);
            }, duration);
        });
    }

    // Run tasks sequentially (one after another)
    async runSequential() {
        this.results = [];
        const startTime = Date.now();
        
        await this.simulateTask('A', 300);
        await this.simulateTask('B', 200);
        await this.simulateTask('C', 400);
        
        const totalTime = Date.now() - startTime;
        return {
            type: 'Sequential',
            results: [...this.results],
            totalTime
        };
    }

    // Run tasks in parallel (all at the same time)
    async runParallel() {
        this.results = [];
        const startTime = Date.now();
        
        const tasks = [
            this.simulateTask('A', 300),
            this.simulateTask('B', 200),
            this.simulateTask('C', 400)
        ];
        
        await Promise.all(tasks);
        
        const totalTime = Date.now() - startTime;
        return {
            type: 'Parallel',
            results: [...this.results],
            totalTime
        };
    }
}

// DOM manipulation functions
export function updateOutput(content) {
    const output = document.getElementById('demo-output');
    if (output) {
        output.innerHTML = content;
    }
}

export function formatResults(result) {
    return `
        <h3>${result.type} Execution</h3>
        <p><strong>Total Time:</strong> ${result.totalTime}ms</p>
        <ul>
            ${result.results.map(r => `<li>${r}</li>`).join('')}
        </ul>
    `;
}

// Initialize the demo when DOM is loaded
if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', () => {
        const demo = new ParallelDemo();
        const button = document.getElementById('demo-button');
        
        if (button) {
            button.addEventListener('click', async () => {
                button.disabled = true;
                button.textContent = 'Running Demo...';
                
                try {
                    // Run sequential first
                    const sequentialResult = await demo.runSequential();
                    updateOutput(formatResults(sequentialResult));
                    
                    // Wait a moment, then run parallel
                    setTimeout(async () => {
                        const parallelResult = await demo.runParallel();
                        const combinedOutput = formatResults(sequentialResult) + formatResults(parallelResult);
                        updateOutput(combinedOutput);
                        
                        button.disabled = false;
                        button.textContent = 'Run Demo';
                    }, 1000);
                    
                } catch (error) {
                    updateOutput(`Error: ${error.message}`);
                    button.disabled = false;
                    button.textContent = 'Run Demo';
                }
            });
        }
    });
}