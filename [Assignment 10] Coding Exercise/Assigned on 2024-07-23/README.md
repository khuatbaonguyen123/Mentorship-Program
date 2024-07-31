# Questions & Solutions

## 📚 Table of Contents
- [Question 1 - Find the most frequent element in the array](#1-find-the-most-frequent-element-in-the-array)
- [Question 2 - Delete element at a given position in the array](#2-delete-element-at-a-given-position-in-the-array)
- [Question 3 - Insert element at a given position in the array](#3-insert-element-at-a-given-position-in-the-array)

### 1. Find the most frequent element in the array
Given an integer n, create an array of n elements, each randomly ranging from 0 to 9. Find the most frequent element in the array.

#### Flowchart:

- **_generateRandomArray(Integer Array a, Integer n)_**: Generate elements ranging from 0 to 9 for the array.

<img width="321" alt="Flow Chart  Find the most frequent element in the array - generateRandomArray" src="https://github.com/user-attachments/assets/973c5e5a-ebb7-4984-ac72-f62508277544">

- **_printArray(Integer Array a, Integer n)_**: Print the array.

<img width="553" alt="Question 1 - Find the most frequent element in the array - printArray" src="https://github.com/user-attachments/assets/f9e3ab4d-d0a2-4858-ae6d-517848a77264">

- **_count(Integer Array a, Integer n, Integer element)_**: Count the number of times an element appears in the array.

<img width="545" alt="Flow Chart  Find the most frequent element in the array - count" src="https://github.com/user-attachments/assets/b9f4f3c0-0fad-4150-90f6-ea820e50e8c6">

- **_maxCount(Integer Array a, Integer n)_**: Return the maxCount (max frequency of an element) in the array.

<img width="609" alt="Flow Chart  Find the most frequent element in the array - maxCount" src="https://github.com/user-attachments/assets/7af7edce-0f01-478f-8943-9925ec8cc6a9">

- **_printMostFrequentElement(Integer Array a, Integer n)_**: Print the most frequent elements in the array.

<img width="785" alt="Flow Chart  Find the most frequent element in the array - printMostFrequentElement" src="https://github.com/user-attachments/assets/1fa9f882-bae1-48c3-8acc-4fb7c9331d52">

- **_Main Function_**

<img width="337" alt="Flow Chart  Find the most frequent element in the array - Main" src="https://github.com/user-attachments/assets/429366de-7666-4fd8-8dd5-e881dd7f0825">

#### Java Code:

```java
import java.util.Random;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class App {

    static Scanner scanner = new Scanner(System.in);
    static Random rand = new Random();

    public static void main(String[] args) throws Exception {
        //Get the size of the array from user
        System.out.print("Enter the size of the array (n): ");
        int n = scanner.nextInt();

        int[] a = new int[n];

        generateRandomArray(a);

        System.out.print("Elements of the array: ");
        printArray(a);

        findAndPrintMostFrequentElement(a);
    }

    public static void generateRandomArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            a[i] = rand.nextInt(10);
        }
    }

    public static void printArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            System.out.print(a[i] + " ");
        }
        System.out.print("\n");
    }

    public static void findAndPrintMostFrequentElement(int[] a) {
        HashMap<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : a) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        int maxCount = frequencyMap.get(a[0]);

        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            if (entry.getValue() > maxCount) {
                maxCount = entry.getValue();
            }
        }

        System.out.print("The most frequent elements are: ");

        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            if (entry.getValue() == maxCount) {
                System.out.print(entry.getKey() + " ");
            }
        }
    }

}
```

### 2. Delete element at a given position in the array
Given an integer n, create an array of n elements, each randomly ranging from 0 to 9. Delete element at a given position in the array.

#### Flowchart:

- **_generateRandomArray(Integer Array a, Integer n)_**: Generate elements ranging from 0 to 9 for the array.

<img width="321" alt="Flow Chart  Find the most frequent element in the array - generateRandomArray" src="https://github.com/user-attachments/assets/973c5e5a-ebb7-4984-ac72-f62508277544">

- **_printArray(Integer Array a, Integer n)_**: Print the array.

<img width="553" alt="Question 1 - Find the most frequent element in the array - printArray" src="https://github.com/user-attachments/assets/f9e3ab4d-d0a2-4858-ae6d-517848a77264">

- **_deleteElement(Integer Array arr, Integer Array newArr, Integer n, Integer pos)_**: Assign the array after deletion to _newArr_.

<img width="497" alt="Flow Chart  Delete element at a given position in the array - deleteElement" src="https://github.com/user-attachments/assets/5f346356-9663-4479-b9c5-e27d0aa5021e">

- **_Main Function_**

<img width="337" alt="Flow Chart  Delete element at a given position in the array - Main" src="https://github.com/user-attachments/assets/a998884f-9185-418a-8af5-de720cbf7c80">

#### Java Code:

```java
import java.util.Random;
import java.util.Scanner;

public class Main {
    private static Scanner scanner = new Scanner(System.in);
    private static Random rand = new Random();
    public static void main(String[] args) throws Exception {
        //Get the size of the array from user
        System.out.print("Enter the size of the array (n): ");
        int n = readInteger();

        int[] arr = new int[n];
        generateRandomArray(arr);

        System.out.print("Elements of the array: ");
        printArray(arr);

        System.out.print("Enter the position to delete: ");
        int pos = inputPos(n);

        arr = deleteElement(arr, pos);

        printArray(arr);
    }

    // Make sure the input is integer
    private static int readInteger() {
        while(!scanner.hasNextInt()) {
            System.out.print("Invalid input. Enter again: ");
            scanner.nextLine();
        }

        return scanner.nextInt();
    } 

    // Make sure the position is valid
    private static int inputPos(int arrayLength) {
        int pos = readInteger();

        while(pos < 0 || pos > arrayLength - 1) {
            System.out.print("Invalid input. Enter again: ");
            pos = readInteger();
        }

        return pos;
    }

    // Generate random array with each element ranging from 0 to 9
    private static void generateRandomArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            a[i] = rand.nextInt(10);
        }
    }

    // Print the array
    private static void printArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            System.out.print(a[i] + " ");
        }
        System.out.print("\n");
    }

    // Return the new array with the element deleted at the given position
    private static int[] deleteElement(int[] arr, int pos) {
        int n = arr.length;
        int[] newArr = new int[n - 1];

        for(int i = 0; i < pos; ++i) {
            newArr[i] = arr[i];
        }

        for(int i = pos; i < n - 1; ++i) {
            newArr[i] = arr[i + 1];
        }

        return newArr;
    }
}
```

### 3. Insert element at a given position in the array
Given an integer n, create an array of n elements, each randomly ranging from 0 to 9. Insert element at a given position in the array.

#### Flowchart:

- **_generateRandomArray(Integer Array a, Integer n)_**: Generate elements ranging from 0 to 9 for the array.

<img width="321" alt="Flow Chart  Find the most frequent element in the array - generateRandomArray" src="https://github.com/user-attachments/assets/973c5e5a-ebb7-4984-ac72-f62508277544">


- **_printArray(Integer Array a, Integer n)_**: Print the array.

<img width="553" alt="Question 1 - Find the most frequent element in the array - printArray" src="https://github.com/user-attachments/assets/f9e3ab4d-d0a2-4858-ae6d-517848a77264">

- **_insertElement(Integer Array arr, Integer Array newArr, Integer n, Integer pos, Integer newValue)_**: Assign the array after insertion to _newArr_.

<img width="497" alt="Flow Chart  Insert element at a given position in the array - insertElement" src="https://github.com/user-attachments/assets/f5f68f95-5555-4b01-89ff-a4e3b1024fe8">

- **_Main Function_**

<img width="337" alt="Flow Chart  Insert element at a given position in the array - Main" src="https://github.com/user-attachments/assets/549fcac6-4667-4dbb-bc23-b00082f615c6">

#### Java Code:

```java
import java.util.Random;
import java.util.Scanner;

public class Main {
    private static Scanner scanner = new Scanner(System.in);
    private static Random rand = new Random();
    public static void main(String[] args) throws Exception {
        //Get the size of the array from user
        System.out.print("Enter the size of the array (n): ");
        int n = readInteger();

        int[] arr = new int[n];
        generateRandomArray(arr);

        System.out.print("Elements of the array: ");
        printArray(arr);

        System.out.print("Enter the position to insert: ");
        int pos = inputPos(n);

        System.out.print("Enter the value to insert: ");
        int value = readInteger();

        arr = insertElement(arr, pos, value);

        printArray(arr);
    }

    // Make sure the input is integer
    private static int readInteger() {
        while(!scanner.hasNextInt()) {
            System.out.print("Invalid input. Enter again: ");
            scanner.nextLine();
        }

        return scanner.nextInt();
    } 

    // Make sure the position is valid
    private static int inputPos(int arrayLength) {
        int pos = readInteger();

        while(pos < 0 || pos > arrayLength - 1) {
            System.out.print("Invalid input. Enter again: ");
            pos = readInteger();
        }

        return pos;
    }

    // Generate random array with each element ranging from 0 to 9
    private static void generateRandomArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            a[i] = rand.nextInt(10);
        }
    }

    // Print the array
    private static void printArray(int[] a) {
        int n = a.length;
        for(int i = 0; i < n; ++i) {
            System.out.print(a[i] + " ");
        }
        System.out.print("\n");
    }

    // Return the new array with the element inserted at the given position
    private static int[] insertElement(int[] arr, int pos, int value) {
        int n = arr.length;
        int[] newArr = new int[n + 1];

        for(int i = 0; i < pos; ++i) {
            newArr[i] = arr[i];
        }

        newArr[pos] = value;

        for(int i = pos; i < n; ++i) {
            newArr[i + 1] = arr[i];
        }

        return newArr;
    }
}
```

