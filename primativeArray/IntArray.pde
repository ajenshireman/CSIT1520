/**
 * IntArray
 * Author: Ajen Shireman
 * 
 * expandable array of int
 */
package primativeArray;

public class IntArray {
    private int[] array;
    
    /* Constructors */
    // Contsructs a new IntArray with an initial size of 0
    public IntArray () {
        array = new int[0];
    }
    
    // Contsructs a new IntArray with the specified initial size
    public IntArray ( int initialSize ) {
        array = new int[initialSize];
    }
    
    // Contsructs a new IntArray from an existing array
    public IntArray ( int[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the IntArray */
    // Returns the number of elements in the IntArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public int get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the IntArray
    public IntArray copy () {
        IntArray newArray = new IntArray(array);
        return newArray;
    }
    
    // Returns a copy of the IntArray's array
    public int[] toArray () {
        int[] newArray = new int[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two IntArrays are equal
    // Returns true if both IntArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( IntArray fArray ) {
        if ( array.length != fArray.size() ) {
            return false;
        }
        else {
            for ( int i = 0; i < this.size(); i++ ) {
                if ( array[i] != fArray.get(i) ) {
                    return false;
                }
            }
            return true;
        }
    }
    
    /* Methods for manipulating the IntArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, int value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the IntArray
    public void add ( int newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the IntArray at the specified position
    public void add ( int newElement, int index ) {
        int[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the IntArray
    public void add ( int[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the IntArray at the specified position
    public void add ( int[] newElements, int index ) {
        int[] newArray = new int[array.length + newElements.length];

        for ( int i = 0; i < index; i++ ) {
            newArray[i] = array[i];
        }
        
        for ( int i = 0; i < newElements.length; i++ ) {
            newArray[i + index] = newElements[i];
        }
        
        for ( int i = index; i < array.length; i++ ) {
            newArray[i + newElements.length] = array[i];
        }
        
        array = newArray;
    }
    
    // Removes the element at the specified index
    public void remove ( int index ) {
        remove(index, index);
    }
    
    // Removes all elements between two specified indices, inclusive
    public void remove ( int index1, int index2 ) {
        int elementsToRemove = index2 - index1 + 1;
        int[] newArray = new int[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the IntArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the IntArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            int[] newArray = new int[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
