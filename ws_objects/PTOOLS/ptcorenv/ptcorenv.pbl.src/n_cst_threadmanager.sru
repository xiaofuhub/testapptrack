$PBExportHeader$n_cst_threadmanager.sru
forward
global type n_cst_threadmanager from n_base
end type
end forward

global type n_cst_threadmanager from n_base
end type
global n_cst_threadmanager n_cst_threadmanager

type variables
Boolean			ib_Running

Integer			ii_maxThreads = 25 //lets not get too crazy here

Long				il_Instance  //total number of threads created for this session

n_cst_threadContainer	inva_ThreadContainers[]
end variables

forward prototypes
public function integer of_getthread (ref n_cst_thread anv_thread, string as_classname)
public function integer of_done (string as_registerid, boolean ab_success)
protected function integer of_createthread (string as_classname)
public function integer of_setthreadcomm (string as_registerid, n_cst_threadcomm anv_threadcomm)
public function integer of_busythreadcount (ref string asa_registerids[], ref string asa_descriptions[])
public function integer of_getthreadcomm (string as_registerid, ref n_cst_threadcomm anv_threadcomm)
end prototypes

public function integer of_getthread (ref n_cst_thread anv_thread, string as_classname);/****************************************************************************************
NAME: 		of_GetThread

ACCESS:		Public
		
ARGUMENTS:	(n_cst_thread anv_thread -- descendant of basic thread class)

RETURNS:		Integer
	
DESCRIPTION: 
				Gets a reference to a thread object.
				
				Return 1 if threadContainer was found/set
				Return 0 if no action
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/
Integer	li_Return = 1
Integer 	li_threads
Integer	i
Boolean	lb_Found
String	ls_Description

li_threads = UpperBound( inva_ThreadContainers )
IF li_Threads >= ii_maxThreads THEN
	li_Return = 0		// maximum threads created
END IF

IF li_Return = 1 THEN
	
	FOR i = 1 TO li_threads
		IF inva_ThreadContainers[i].of_GetClassName() = as_ClassName THEN
			IF inva_ThreadContainers[i].of_Busy() THEN
				CONTINUE
			ELSE
				lb_Found = True  //Found one that is not busy
				EXIT
			END IF
		END IF
	NEXT

	IF NOT lb_Found THEN
		// class thread does not exist, create it
		i = of_createThread(as_ClassName) 
		IF i = -1 THEN
			li_Return = -1
		END IF
		
	END IF
	
END IF

//We found available thread or created a new one successfully
IF li_Return = 1 THEN
	
	anv_thread = inva_ThreadContainers[i].of_GetThread()
	
	//Set threadContainer info so that we can query busy status while
	//the thread is doing work.
	IF isValid(anv_Thread) THEN
		inva_ThreadContainers[i].of_SetDescription(anv_Thread.of_GetDescription())
		inva_ThreadContainers[i].of_SetBusy(True)
	ELSE
		li_Return = -1
	END IF
	
END IF

Return li_Return
end function

public function integer of_done (string as_registerid, boolean ab_success);/****************************************************************************************
NAME: 		of_Done

ACCESS:		Public
		
ARGUMENTS:	(string as_registerid, boolean ab_success)

RETURNS:		Integer
	
DESCRIPTION: 
				Finds the corresponding threadContainer using the registerid
				Sets busy status of the threadContainer to false.
				
				/*
					Also Destroys the threadContainer, and removes it from manager's list
					see comment below
				*/
				
				Return 1 if threadContainer was found/set
				Return 0 if no action
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/20/07 - Maury
***************************************************************************************/
Integer	li_Return
Integer	i, ll_count

n_cst_ThreadContainer	lnva_Temp[] 
n_cst_ThreadContainer	lnva_Empty[]

//Find the thread Container and set to done / destroy it
ll_Count = Upperbound(inva_Threadcontainers)
FOR i = 1 TO ll_Count
	IF as_registerId = inva_threadContainers[i].of_GetRegisterId() THEN
		inva_threadContainers[i].of_SetBusy(False)
		Destroy(inva_ThreadContainers[i]) //We may not want to always do this, see comment below
		li_Return = 1
	END IF
NEXT

/*
	We may not always want to destroy the thread when done, but for right now we will, to ensure that it will 
	disconnect fromt the database.
	In other words, we are assuming the n_cst_thread_decendent may have made a db connection for its thread
	so now we want to destroy the thread so that it will disconnect.
*/

//Store remaining threads in temp array
FOR i = 1 TO ll_Count
	IF isValid(inva_ThreadContainers[i]) THEN
		lnva_Temp[UpperBound(lnva_Temp) + 1] = inva_ThreadContainers[i]
	END IF
NEXT

//Reset container list
inva_ThreadContainers = lnva_Temp

/*
	end
*/

Return li_Return

end function

protected function integer of_createthread (string as_classname);/****************************************************************************************
NAME: 		of_CreateThread	

ACCESS:		Private
		
ARGUMENTS:	(string as_className)

RETURNS:		Integer
	
DESCRIPTION: 
				Spawns a thread using the sharedobjectregister function.
				
				Thread is wrapped in a ThreadContainer which we now have a reference to
				in inva_ThreadContainers.
				
				Note: The primary purpose of the thread container obj is to set/get the busy
						status of the thread. We cannot get the busy status off the thread itself 
						while it is doing intensive processing.
						
				Returns new index of the threadConatiner array if successful
				Return -1 if failure
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/

Integer			li_new
Integer			li_Return
String			ls_Instance

ErrorReturn		err

n_cst_Thread	lnv_NewThread

ls_Instance = "T" + String( il_Instance )

//Register the object as shared
//This will open a separate runtime session for the object
err = SharedObjectRegister( as_ClassName, ls_Instance )

IF err <> Success! THEN 
	li_Return = -1
END IF

IF li_Return <> -1 THEN
	
	err = SharedObjectGet( ls_Instance, lnv_NewThread )
	
	IF err = Success! THEN
		
		//Initailze thread object
		lnv_NewThread.of_setManager( This )
		lnv_NewThread.of_SetRegisterId(ls_Instance)
		
		//initailize container for thread
		li_new = upperBound( inva_ThreadContainers ) + 1
		inva_ThreadContainers[li_new] = Create n_cst_ThreadContainer
		inva_ThreadContainers[li_new].of_SetThread(lnv_NewThread)
		inva_ThreadContainers[li_new].of_SetClassName(as_ClassName)
		inva_ThreadContainers[li_new].of_SetRegisterId(ls_Instance)
		
		//increment unique instance counter
		il_Instance ++
		
		li_Return = li_new //Return new index
	END IF
	
END IF

Return li_Return
end function

public function integer of_setthreadcomm (string as_registerid, n_cst_threadcomm anv_threadcomm);/****************************************************************************************
NAME: 		of_SetThreadComm

ACCESS:		Public
		
ARGUMENTS:	(string	as_registerid, n_cst_threadcomm	anv_threadcomm)

RETURNS:		Integer
	
DESCRIPTION: 
			   Finds the thread corresponding the as_registerid
				
				Sets the threadcomm object on threadContainer
				
				Return 1 if success
				Return 0 if no action
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/
Integer	li_Return
Integer	li_ThreadCount, i

li_ThreadCount = UpperBound(inva_ThreadContainers)
FOR i = 1 TO li_ThreadCount
	IF inva_ThreadContainers[i].of_GetRegisterId() = as_RegisterId THEN
		inva_Threadcontainers[i].of_SetThreadComm(anv_ThreadComm)
		li_Return = 1
	END IF
NEXT

Return li_Return
end function

public function integer of_busythreadcount (ref string asa_registerids[], ref string asa_descriptions[]);/**************************************************************************************
NAME: 		of_BusyThreadCount	

ACCESS:		Public
		
ARGUMENTS:	(ref asa_descriptions[])

RETURNS:		Integer
	
DESCRIPTION: 
				Returns number of threads that are currently busy and passes out a list of
				the registerids and descriptions
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/

Integer	li_ThreadCount, li_BusyCount, i
String	lsa_Descriptions[], lsa_RegisterIds[]

li_ThreadCount = UpperBound(inva_ThreadContainers)
FOR i = 1 TO li_ThreadCount
	IF isValid(inva_ThreadContainers[i]) THEN
		IF inva_ThreadContainers[i].of_Busy() THEN
			li_BusyCount ++
			lsa_Descriptions[i] = inva_ThreadContainers[i].of_GetDescription()
			lsa_RegisterIds[i] = inva_ThreadContainers[i].of_GetRegisterId()
		END IF
	END IF
NEXT

asa_Descriptions = lsa_Descriptions
asa_RegisterIds = lsa_RegisterIds

Return li_BusyCount
end function

public function integer of_getthreadcomm (string as_registerid, ref n_cst_threadcomm anv_threadcomm);/****************************************************************************************
NAME: 		of_GetThreadComm

ACCESS:		Public
		
ARGUMENTS:	(string	as_registerid, ref n_cst_threadcomm	anv_threadcomm)

RETURNS:		Integer
	
DESCRIPTION: 
			   Finds the thread corresponding the as_registerid
				
				Passes out the threadcomm object on threadContainer
				
				Return 1 if success
				Return -1 if error getting threadcomm
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/
Integer	li_Return = -1
Integer	li_ThreadCount, i

li_ThreadCount = UpperBound(inva_ThreadContainers)
FOR i = 1 TO li_ThreadCount
	IF inva_ThreadContainers[i].of_GetRegisterId() = as_RegisterId THEN
		anv_ThreadComm = inva_Threadcontainers[i].of_GetThreadComm()
		IF isValid(anv_ThreadComm) THEN
			li_Return = 1
		END IF
	END IF
NEXT

Return li_Return
end function

on n_cst_threadmanager.create
call super::create
end on

on n_cst_threadmanager.destroy
call super::destroy
end on

event destructor;// Cleanup
Integer	i, li_threads

li_threads = upperBound( inva_threadContainers )
FOR i = 1 TO li_threads
	Destroy(inva_threadContainers[i])
NEXT
end event

event constructor;call super::constructor;/* 

See http://www.sybase.com/detail?id=47802

Spawning a new thread:

A new PowerBuilder thread is spawned using the SharedObjectRegister function. 
But to get a method in that thread to execute asynchronously it must be coded using the Powerscript POST 
statement. When you execute a shared object method (function or event), without the POST keyword the calling 
script will run the method in the other thread but wait for it to complete before continuing on to the next line 
of code in the script. When you post a method, it is added to the object's queue and executed in its turn. 
In most cases, the method is executed when the current script is finished. 
Because it's return value is not available to the calling script, 
methods that are intended to execute in a separate thread should not have a return value, 
however, if they do have a return value it will just be ignored, no error will be generated. 

Memory space

All shared objects that are instantiated using the SharedObjectRegister function get their own memory space, 
and therefore they get their own global variables. The shared object cannot reference any object back in the 
main PowerBuilder thread or any other shared object thread. The thread for a shared object is created using 
the Application object definition for the application. The shared object session has its own copy of the 
application's global variables; however the events for the Application object are not triggered. 
Therefore, if you want the shared object to perform any setup operations (such as initializing variables), 
you need to code these operations in the Constructor event of the shared object because the 
Open and ConnectionBegin events of the Application object will not be fired. 

*/
end event

