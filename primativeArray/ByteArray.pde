/**
 * ByteArray
 * Author: Ajen Shireman
 * 
 * expandable array of byte
 */
package primativeArray;

public class ByteArray {
    private byte[] array;
    
    /* Constructors */
    // Contsructs a new ByteArray with an initial size of 0
    public ByteArray () {
        array = new byte[0];
    }
    
    // Contsructs a new ByteArray with the specified initial size
    public ByteArray ( int initialSize ) {
        array = new byte[initialSize];
    }
    
    // Contsructs a new ByteArray from an existing array
    public ByteArray ( byte[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the ByteArray */
    // Returns the number of elements in the ByteArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public byte get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the ByteArray
    public ByteArray copy () {
        ByteArray newArray = new ByteArray(array);
        return newArray;
    }
    
    // Returns a copy of the ByteArray's array
    public byte[] toArray () {
        byte[] newArray = new byte[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two ByteArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( ByteArray fArray ) {
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
    
    /* Methods for manipulating the ByteArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, byte value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the ByteArray
    public void add ( byte newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the ByteArray at the specified position
    public void add ( byte newElement, int index ) {
        byte[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the ByteArray
    public void add ( byte[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the ByteArray at the specified position
    public void add ( byte[] newElements, int index ) {
        byte[] newArray = new byte[array.length + newElements.length];

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
        byte[] newArray = new byte[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the ByteArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the ByteArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            byte[] newArray = new byte[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
