(*! @abstract <em>[text]</em> ASCollections's name. *)
property name : "ASCollections"
(*! @abstract <em>[text]</em> ASCollections's version. *)
property version : "1.0.0"
(*! @abstract <em>[text]</em> ASCollections's id. *)
property id : "com.kraigparkinson.ASCollections"

script Iterable
	on iterator()
	end iterator
end script

script Collection
	property parent : Iterable
	
	on asList()
	end asList 
	
	on containsElement(element)
	end containsElement
	
	on containsAll(aCollection)
	end containsAll
	
	on itemCount()
	end itemCount
	
	on add(anElement)
	end add
	
	on addAll(aCollection)
	end addAll
	
	on remove(anElement)
	end remove
	
	on removeAll(aCollection)
	end removeAll
	
	on retainAll(aCollection)
	end retainAll
	
	on iterator()
	end iterator
	
end script

script Iterator
	on hasNext()
	end hasNext
	
	on next()
	end next
	
	on remove()
	end remove
end script

script Map
	on getValue(aKey)
	end getValue
	
	on putValue(aKey, value)	
	end putValue
	
	on containsValue(aKey)
	end containsValue
	
	on removeValue(aKey)
	end removeValue
	
	on keys()
	end keys
end script

on makeMap()
	script MapImpl
		property parent : Map
		property values : { }
		
		on getValue(aKey)
			repeat with aKeyValuePair in values
				if (item 1 in aKeyValuePair equals aKey)
					return item 2 in aKeyValuePair
				end
			end repeat
			
			error "Map does not contain value for key: " & aKey
		end getValue
		
		on getKeyValuePair(aKey)
			repeat with aKeyValuePair in values
				if (item 1 in aKeyValuePair equals aKey)
					return aKeyValuePair
				end
			end repeat
			
			return missing value
		end getKeyValuePair
	
		on putValue(aKey, aValue)
			if (containsValue(aKey))
				set kvp to getKeyValuePair(aKey)
				set item 2 of kvp to aValue
			else
				set values to values & { {aKey, aValue} }
			end if 
		end putValue
		
		on containsValue(aKey)
			return (getKeyValuePair(aKey) is not missing value)			
		end containsValue
		
		on removeValue(aKey)
			if (containsValue(aKey))
				set newValues to { }
				
				repeat with aKeyValuePair in values
					if ((item 1 in aKeyValuePair) is not equal to aKey)
						set newValues to newValues & aKeyValuePair
					else 
						log "Removed " & aKey & " from map."
					end
				end repeat
				
				set values to newValues
			else
				error "No value for key: " & aKey	
			end if
		end removeValue
		
		on keys()
			set keys to { }
			repeat with aKeyValuePair in values
				set end of keys to item 1 in aKeyValuePair
			end repeat
			return keys
		end keys
	end script
end makeMap

script iList
	property parent : Collection

	on indexOf(candidate)
	end indexOf
end script

on createArrayListWithValues(values)
	script ArrayList
		property parent : iList
	 
		property listValues : values
	
		on iterator()
			script ArrayListIterator
				property listIndex : 0
				property lastItem : missing value
			
				on hasNext()
					return (listIndex < count of listValues)
				end hasNext

				on next()
					set listIndex to listIndex + 1
					set lastItem to item listIndex of listValues
					return lastItem
				end next

				on remove()
					my remove(lastItem)
				end remove
			end 
			return ArrayListIterator
		end iterator
	
		on containsElement(element)
			log "START" & space & "containsElement(" & element & ")" 

			set doesContainElement to false
		
			repeat with listItem in listValues
				log "Checking list item, >>" & listItem & "<< against >>" & element & "<<" 
				if (element equals listItem's contents) then 
	--			if (listItem equals element) then 
					log "yes " & element
					set doesContainElement to true
					exit repeat
				else
					log "not " & element
				end if
			end repeat

			log "STOP" & space & "containsElement_" & doesContainElement
			return doesContainElement
	--		*)
		
	--		set theResult to ( listValues contains { element's contents } )
	--		log "STOP" & space & "containsElement(" & element & ")" & theResult
	--		return theResult
		end containsElement

		on containsAll(aCollection)
	--		set itr to aCollection's iterator
		
	--		repeat while itr's hasNext() 
	--			set nextItem to itr's next()'s contents
	--			if (not containsElement(nextItem)) then return false 
	--		end repeat			
		
	--		return true
			return aCollection's listValues contains element
		end containsAll

		on itemCount()
			return count of listValues
		end itemCount

		on add(anElement)
			set end of listValues to anElement
			return true
		end add

		on addAll(aCollection)
			set changedList to false
		
			set itr to aCollection's iterator()
		
			repeat while itr's hasNext()
				if (add(itr's next()'s contents)) then set changedList to true
			end repeat
		
			return changedList
		end addAll

		on remove(itemToDelete)
	--		if (containsElement(itemToDelete)) then
				set modifiedList to false
			
				set newValues to { }
			
				repeat with listElement in listValues
					if (listElement's contents is not itemToDelete)
						set end of newValues to listElement's contents
					else
						set modifiedList to true
					end 
				end repeat
			
				set listValues to newValues
			
				return modifiedList
	--		else 
	--			return false
	--		end if 
		end remove

		on removeAll(aCollection)
			set listHasChanged to false
		
			set itr to aCollection's iterator()
		
			repeat while itr's hasNext()
				if (remove(itr's next()'s contents)) then set listHasChanged to true
			end repeat
		
			return listHasChanged
		end removeAll

		on retainAll(aCollection)
			set listHasChanged to false
			set newValues to { }
		
			set itr to aCollection's iterator()
		
			repeat while itr's hasNext()
				set anItem to itr's next()'s contents
			
				if (containsElement(anItem)) then set newValues to newValues & { anItem } 
			end repeat
			set listValues to newValues
		
			return listHasChanged
		end retainAll

		on indexOf(anElement)
			log "Checking for index of " & anElement
			if (containsElement(anElement))
				set indexValue to 0
		
				repeat with listItem in listValues
				
					set indexValue to indexValue + 1
			
					log "inspecting index of " & listItem
				
					if (listItem's contents equals anElement) then exit repeat
				end repeat	
			
				return indexValue		
			else
				return -1
			end if
		end indexOf
	
		on clear()
			set listValues to { }
		end clear
	end script
	return ArrayList
end createArrayListWithValues

on createArrayList()
	return createArrayListWithValues({})
end createArrayList

script Stack
	on push(anItem)
	end push
	
	on pop()
	end pop
	
	on peek()
	end peek
	
	on height()
	end height
end script

on makeStack()
	script StackImpl
		property parent : Stack
		property values : { }
	
		on push(anItem)
			set values to values & { anItem }
		end push
	
		on pop()
			if (count of values equals 0)
				error "Don't pop an empty stack.  Check height first."
			else if (count of values equals 1) 
				set anItem to item 1 of values
				set values to { }
			else
				set anItem to item -1 of values
				set values to items 1 thru -2 of values
			end if 
				
			return anItem
		end pop
		
		on peek()
			return item -1 of values
		end peek
		
		on height()
			return count of values
		end height
	end script
	return StackImpl
end makeStack
