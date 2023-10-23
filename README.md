# Dexcom Code Assessment Documentation

## Refactorings

### 1. Error Handling
- **Improvement Process:** Introduced a custom error type IIQMError to categorize and specify different types of errors.
- **Reasoning:** Increases code robustness and user-friendliness.
- **Benefit for Future Developers:** Easier understanding and debugging of potential issues and errors.

### 2. Code Modularization
- **Improvement Process:** Broke down monolithic methods into smaller, well-named functions.
- **Reasoning:** Increases code readability and maintainability.
- **Benefit for Future Developers:** Each function’s purpose and operation is clearer, enhancing understandability and testability.

### 3. Parameter Types and Method Signatures
- **Improvement Process:** Updated method signatures for error propagation and return types.
- **Reasoning:** Enhances code robustness.
- **Benefit for Future Developers:** Clearer expectations of functions’ inputs, outputs, and errors.

### 4. Variable Names
- **Improvement Process:** Updated to descriptive and self-explanatory names.
- **Reasoning:** Improves readability.
- **Benefit for Future Developers:** Reduces cognitive load for code comprehension.

### 5. Removed Forced Unwrapping
- **Improvement Process:** Eliminated forced unwrapping for code safety.
- **Reasoning:** Reduces runtime error risks.
- **Benefit for Future Developers:** Enhances code stability and reliability.

### 6. Comments
- **Improvement Process:** Added comments for code clarity.
- **Reasoning:** Conveys code intent and logic.
- **Benefit for Future Developers:** Assists in quick comprehension and maintenance.

### 7. Test Cases
- **Improvement Process:** Introduced unit test cases to validate the functionality of the code.
- **Reasoning:** Test cases ensure that the code works as expected and helps in identifying bugs and issues. It verifies file reading, IIQM calculations, error handling, and performance.
- **Benefit for Future Developers:** Provides a safety net and documentation. Developers can make changes or additions with confidence, knowing they’ll quickly identify if something breaks. It also serves as a form of documentation on how the functions are expected to behave.

### 8. Code Formatting and Style
- **Improvement Process:** Adopted a consistent coding style and formatting throughout the codebase.
- **Reasoning:** A consistent code style makes the code easier to read and understand.
- **Benefit for Future Developers:** Easier to read code, less cognitive load when navigating through the code.

## Optimizations: Improved Data Insertion

### 1. Explain how your optimization works and why you took this approach
The core optimization strategy I implemented was improving the data insertion process. Initially, the code sorted the entire dataset every time a new element was added, which has a time complexity of O(n log n) per insertion. This approach was not efficient, especially as the size of the dataset grows. To address this, I utilized a binary search method to find the correct position for the new element, ensuring the dataset remains in sorted order while reducing the need for full array sorting with every new element addition. The binary search operates with a time complexity of O(log n) to find the insertion point, and then O(n) for inserting the element, offering a performance improvement.
This approach was chosen due to its balance of improved performance, manageable complexity, and alignment with the project's time constraints. It provided a significant performance boost while maintaining code readability and manageability, setting a solid foundation for any further optimizations.

### 2. Would your approach continue to work if there were millions or billions of input values?
The binary search approach for data insertion would continue to function with larger datasets containing millions or billions of values. However, the performance may degrade due to the O(n) time complexity associated with inserting elements. As the dataset grows, the time taken for each insertion operation increases, which could lead to performance issues.
In scenarios with such large datasets, transitioning to more efficient data structures like self-balancing binary search trees could be considered to maintain performance efficiency. This augmented data structure can maintain a sorted order while allowing for faster insertions and deletions, which would be crucial for handling very large datasets efficiently.

### 3. Would your approach still be efficient if you needed to store the intermediate state between each IQM calculation in a data store? If not, how would you change it to meet this requirement?
Storing intermediate states between each IQM calculation adds an additional layer of complexity. The current approach of binary search insertion could still function, but the efficiency may be affected due to the overhead of storing and retrieving intermediate states from a data store. The time complexity for inserting elements would remain the same, but the overall process could become slower due to the data store operations.
To address this requirement, an incremental algorithm that can update the IQM in constant time or logarithmic time as new data is added would be more suitable. Such an approach would minimize the need for recalculating the IQM from scratch for each new data point, thus reducing the overhead associated with storing and retrieving intermediate states.
Implementing an incremental algorithm, along with leveraging a more efficient data structure, could provide a robust solution that meets the requirement of storing intermediate states efficiently, especially in scenarios with very large datasets. This approach would set a strong foundation for a system capable of handling the increased complexity while maintaining optimized performance. While the further optimizations identified are promising, they introduce a higher level of complexity. Implementing and thoroughly testing these optimizations would likely extend beyond the allocated project timeline. The goal was to balance between optimization, code readability, and the project's time constraints to deliver a reliable and improved solution promptly.
