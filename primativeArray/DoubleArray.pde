/**
 * DoubleArray
 * Author: Ajen Shireman
 * 
 * expandable array of double
 */
package primativeArray;

public class DoubleArray {
    private double[] array;
    
    /* Constructors */
    // Contsructs a new DoubleArray with an initial size of 0
    public DoubleArray () {
        array = new double[0];
    }
    
    // Contsructs a new DoubleArray with the specified initial size
    public DoubleArray ( int initialSize ) {
        array = new double[initialSize];
    }
    
    // Contsructs a new DoubleArray from an existing array
    public DoubleArray ( double[] array ) {
        this(array.length);
        
        for ( int i = 0; i < array.length; i++ ) {
            this.array[i] = array[i];
        }
    }
    
    /* Methods for getting information about the DoubleArray */
    // Returns the number of elements in the DoubleArray
    public int size () {
        return array.length;
    }
    
    // Returns the element at the specified index
    public double get ( int index ) {
        return array[index];
    }
    
    // Returns a copy of the DoubleArray
    public DoubleArray copy () {
        DoubleArray newArray = new DoubleArray(array);
        return newArray;
    }
    
    // Returns a copy of the DoubleArray's array
    public double[] toArray () {
        double[] newArray = new double[array.length];

        for ( int i = 0; i < array.length; i++ ) {
            newArray[i] = array[i];
        }
        
        return newArray;
    }
    
    // Checks if two DoubleArrays are equal
    // Returns true if both FLoatArrays are the same size and if all elements 
    //   are the same and in the same place, else returns false
    public boolean equals ( DoubleArray fArray ) {
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
    
    /* Methods for manipulating the DoubleArray */
    // Replaces the value at the specified index with the specified value
    public void set ( int index, double value ) {
        array[index] = value;
    }
    
    // Appends a new element to the end of the DoubleArray
    public void add ( double newElement ) {
        add(newElement, array.length);
    }
    
    // Inserts a new element into the DoubleArray at the specified position
    public void add ( double newElement, int index ) {
        double[] e = { newElement };
        add(e, index);
    }
    
    // Appends a new array of elements to the end of the DoubleArray
    public void add ( double[] newElements) {
        add(newElements, array.length);
    }
    
    // Inserts a new array of elements into the DoubleArray at the specified position
    public void add ( double[] newElements, int index ) {
        double[] newArray = new double[array.length + newElements.length];

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
        double[] newArray = new double[array.length - elementsToRemove];
        
        for ( int i = 0; i < index1; i++ ) {
                newArray[i] = array[i];
        }
        
        for ( int i = index1; i < array.length - elementsToRemove; i++ ) {
            newArray[i] = array[i + elementsToRemove];
        }
        
        array = newArray;
    }
    
    // Removes all elements from the DoubleArray
    public void clear () {
        remove(0, array.length - 1);
    }
    
    // Increases the DoubleArray's size to the specified size if needed
    public void ensureCapacity ( int minSize ) {
        if ( array.length >= minSize ) return;
        else {
            double[] newArray = new double[minSize];

            for ( int i = 0; i < array.length; i++ ) {
                newArray[i] = array[i];
            }
            
            array = newArray;
        }
    }
}

