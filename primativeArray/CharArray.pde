/**
 * CharArray
 * Author: Ajen Shireman
 * 
 * expandable array of char
 */
package primativeArray;

public class CharArray {
    private char[] array;
    
    /* Constructors */
    // Contsructs a new CharArray with an initial size of 0
    public CharArray () {
        array = new char[0];
    }
    
    // Contsructs a new CharArray with the specified initial size
    public CharArray ( int initialSize ) {
        array = new char[initialSize];
    }
    
    // Contsructs a new CharArray from an existing array
    public CharArray ( char[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the CharArray */
    // Returns the number of elements in the CharArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public char get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the CharArray
    public CharArray copy () {
        CharArray newArray = new CharArray(array);
        return newArray;
    }
    
    // Returns a copy of the CharArray's array
    public char[] toArray () {
        char[] newArray = new char[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two CharArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( CharArray fArray ) {
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
    
    /* Methods for manipulating the CharArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, char value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the CharArray
    public void add ( char newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the CharArray at the specified position
    public void add ( char newElement, int index ) {
        char[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the CharArray
    public void add ( char[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the CharArray at the specified position
    public void add ( char[] newElements, int index ) {
        char[] newArray = new char[array.length + newElements.length];

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
        char[] newArray = new char[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the CharArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the CharArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            char[] newArray = new char[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}
