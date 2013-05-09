/**
 * ShortArray
 * Author: Ajen Shireman
 * 
 * expandable array of short
 */
package primativeArray;

public class ShortArray {
    private short[] array;
    
    /* Constructors */
    // Contsructs a new ShortArray with an initial size of 0
    public ShortArray () {
        array = new short[0];
    }
    
    // Contsructs a new ShortArray with the specified initial size
    public ShortArray ( int initialSize ) {
        array = new short[initialSize];
    }
    
    // Contsructs a new ShortArray from an existing array
    public ShortArray ( short[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the ShortArray */
    // Returns the number of elements in the ShortArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public short get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the ShortArray
    public ShortArray copy () {
        ShortArray newArray = new ShortArray(array);
        return newArray;
    }
    
    // Returns a copy of the ShortArray's array
    public short[] toArray () {
        short[] newArray = new short[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two ShortArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( ShortArray fArray ) {
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
    
    /* Methods for manipulating the ShortArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, short value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the ShortArray
    public void add ( short newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the ShortArray at the specified position
    public void add ( short newElement, int index ) {
        short[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the ShortArray
    public void add ( short[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the ShortArray at the specified position
    public void add ( short[] newElements, int index ) {
        short[] newArray = new short[array.length + newElements.length];

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
        short[] newArray = new short[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the ShortArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the ShortArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            short[] newArray = new short[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
