/**
 * LongArray
 * Author: Ajen Shireman
 * 
 * expandable array of long
 */
package primativeArray;

public class LongArray {
    private long[] array;
    
    /* Constructors */
    // Contsructs a new LongArray with an initial size of 0
    public LongArray () {
        array = new long[0];
    }
    
    // Contsructs a new LongArray with the specified initial size
    public LongArray ( int initialSize ) {
        array = new long[initialSize];
    }
    
    // Contsructs a new LongArray from an existing array
    public LongArray ( long[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the LongArray */
    // Returns the number of elements in the LongArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public long get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the LongArray
    public LongArray copy () {
        LongArray newArray = new LongArray(array);
        return newArray;
    }
    
    // Returns a copy of the LongArray's array
    public long[] toArray () {
        long[] newArray = new long[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two LongArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( LongArray fArray ) {
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
    
    /* Methods for manipulating the LongArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, long value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the LongArray
    public void add ( long newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the LongArray at the specified position
    public void add ( long newElement, int index ) {
        long[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the LongArray
    public void add ( long[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the LongArray at the specified position
    public void add ( long[] newElements, int index ) {
        long[] newArray = new long[array.length + newElements.length];

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
        long[] newArray = new long[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the LongArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the LongArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            long[] newArray = new long[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
