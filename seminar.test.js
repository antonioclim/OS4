import { describe, it, expect, beforeEach, vi } from 'vitest'
import { ParallelDemo, updateOutput, formatResults } from './seminar.js'

describe('ParallelDemo', () => {
    let demo

    beforeEach(() => {
        demo = new ParallelDemo()
    })

    it('should create a new instance with empty results', () => {
        expect(demo.results).toEqual([])
    })

    it('should simulate a task with correct timing', async () => {
        const startTime = Date.now()
        const result = await demo.simulateTask('Test', 100)
        const endTime = Date.now()
        
        expect(result).toBe('Task Test completed in 100ms')
        expect(demo.results).toContain(result)
        expect(endTime - startTime).toBeGreaterThanOrEqual(90) // Allow some timing variance
    })

    it('should run tasks sequentially', async () => {
        const startTime = Date.now()
        const result = await demo.runSequential()
        const endTime = Date.now()
        
        expect(result.type).toBe('Sequential')
        expect(result.results).toHaveLength(3)
        expect(result.results[0]).toContain('Task A')
        expect(result.results[1]).toContain('Task B')
        expect(result.results[2]).toContain('Task C')
        
        // Sequential should take at least 900ms (300 + 200 + 400)
        expect(result.totalTime).toBeGreaterThanOrEqual(850)
        expect(endTime - startTime).toBeGreaterThanOrEqual(850)
    })

    it('should run tasks in parallel', async () => {
        const startTime = Date.now()
        const result = await demo.runParallel()
        const endTime = Date.now()
        
        expect(result.type).toBe('Parallel')
        expect(result.results).toHaveLength(3)
        
        // Parallel should take around 400ms (the longest task)
        expect(result.totalTime).toBeLessThan(500)
        expect(endTime - startTime).toBeLessThan(500)
    })

    it('should demonstrate performance difference between sequential and parallel', async () => {
        const sequentialResult = await demo.runSequential()
        const parallelResult = await demo.runParallel()
        
        expect(sequentialResult.totalTime).toBeGreaterThan(parallelResult.totalTime)
        expect(sequentialResult.results).toHaveLength(3)
        expect(parallelResult.results).toHaveLength(3)
    })
})

describe('DOM functions', () => {
    beforeEach(() => {
        // Setup DOM
        document.body.innerHTML = '<div id="demo-output"></div>'
    })

    it('should update output element', () => {
        const testContent = '<p>Test content</p>'
        updateOutput(testContent)
        
        const output = document.getElementById('demo-output')
        expect(output.innerHTML).toBe(testContent)
    })

    it('should format results correctly', () => {
        const testResult = {
            type: 'Test',
            totalTime: 500,
            results: ['Result 1', 'Result 2']
        }
        
        const formatted = formatResults(testResult)
        
        expect(formatted).toContain('<h3>Test Execution</h3>')
        expect(formatted).toContain('<strong>Total Time:</strong> 500ms')
        expect(formatted).toContain('<li>Result 1</li>')
        expect(formatted).toContain('<li>Result 2</li>')
    })
})