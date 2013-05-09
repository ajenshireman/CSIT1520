/**
 * BooleanArray
 * Author: Ajen Shireman
 * 
 * expandable array of boolean
 */
package primativeArray;

public class BooleanArray {
    private boolean[] array;
    
    /* Constructors */
    // Contsructs a new BooleanArray with an initial size of 0
    public BooleanArray () {
        array = new boolean[0];
    }
    
    // Contsructs a new BooleanArray with the specified initial size
    public BooleanArray ( int initialSize ) {
        array = new boolean[initialSize];
    }
    
    // Contsructs a new BooleanArray from an existing array
    public BooleanArray ( boolean[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the BooleanArray */
    // Returns the number of elements in the BooleanArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public boolean get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the BooleanArray
    public BooleanArray copy () {
        BooleanArray newArray = new BooleanArray(array);
        return newArray;
    }
    
    // Returns a copy of the BooleanArray's array
    public boolean[] toArray () {
        boolean[] newArray = new boolean[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two BooleanArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( BooleanArray fArray ) {
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
    
    /* Methods for manipulating the BooleanArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, boolean value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the BooleanArray
    public void add ( boolean newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the BooleanArray at the specified position
    public void add ( boolean newElement, int index ) {
        boolean[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the BooleanArray
    public void add ( boolean[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the BooleanArray at the specified position
    public void add ( boolean[] newElements, int index ) {
        boolean[] newArray = new boolean[array.length + newElements.length];

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
        boolean[] newArray = new boolean[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the BooleanArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the BooleanArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            boolean[] newArray = new boolean[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
