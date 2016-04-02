# About this function

This function took a fair bit to understand (not so much to write).  A lot of this came from the very helpful thread: [link](https://class.coursera.org/rprog-015/forum/thread?thread_id=767)

***
Here's what I learnt:

## makeCacheMatrix

*This function returns a list, not a matrix.  It is actually a list of functions, tied to a specific environment.*

1. create an object with 1000 random number
> x <- rnorm(1000)

2. create a square matrix with the object
> mymatrix <- matrix(x, 10, 10)

3. test it
> head(x)
> head(mymatrix)

4. create an object with makeCacheMatrix()
> run the the code cachematrix.R
> mytest <- makeCacheMatrix(mymatrix)

5. test it - you should see your matrix returned
> class(mytest)
> mytest$get()
> mytest$getinv() 

*we haven't cached the inverse yet, so this will be NULL*  At this point, all that is cached is the matrix.

6. The functions in the object all share the same environment:
> mytest

**this is NOT the object's environment**, as the object only exists in the global environment

7. We can name the environment to work with it and list all elements in the environment:
> myteste <- environment(mytest$set)
> ls(environment(mytest$get))
> get("m",environment(mytest$get)) 

*we haven't cached "m", so it will be NULL

## cacheSolve

*This function checks whether the inverse of the matrix exists, if it does, it gets the cached inverse and returns it.  If it doesn't, it inverses the matrix and returns the value.*

1. When the function is run, it will return the inverse of the matrix
> cacheSolve(mytest)

2. You can test that "m" has been populated in the environment
> get("m",environment(mytest$get))

3. Re-running the function will return a message that the inverse is being pulled from the cachce:
> cacheSolve(mytest) *getting cached data

## The effectiveness of the cache

There is a nice bit of function to test the effectiveness of the function on a large, square matrix of 1M objects:

1. Create the matrix of 1M objects
> x <- rnorm(1:1000000)

> mymatrix <- matrix(x,1000,1000)

> head(mymatrix)

2. Create a test function to solve the for the inverse, recording the durations of both executions:

> test = function(mat){
        temp = makeCacheMatrix(mymatrix)
        
        start.time = Sys.time()
        cacheSolve(temp)
        dur = Sys.time() - start.time
        print(dur)
        
        start.time = Sys.time()
        cacheSolve(temp)
        dur = Sys.time() - start.time
        print(dur)
        
> }

13. Upon running, you should get output similar to the below:

> test(mymatrix)
Time difference of 1.053222 secs
getting cached data
Time difference of 0 secs

Enjoy!