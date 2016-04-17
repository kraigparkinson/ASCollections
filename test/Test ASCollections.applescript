(*!
	@header Test ASCollections
		ASCollections self tests.
	@abstract License: GNU GPL, see COPYING for details.
	@author Kraig Parkinson
	@copyright 2015 kraigparkinson
*)

property collections : script "com.kraigparkinson/ASCollections"

property parent : script "com.lifepillar/ASUnit"
property suite : makeTestSuite("ASCollections")

my autorun(suite)

script |ArrayList|
	property parent : TestSet(me)

	on setUp()
	end setUp
	
	on tearDown()
	end tearDown
	
	script |index of|
		property parent : UnitTest(me)

		set aList to collections's createArrayList()
		
		assert(aList's add("foo"), "Should have changed the list with the first item.")
		assert(aList's containsElement("foo"), "Should have the item.")
		assertEqual(1, aList's indexOf("foo"))
	
		assert(aList's add("bar"), "Shoud have changed the list with the second item.") 
		assert(aList's containsElement("bar"), "bar's missing")
		assertEqual(2, aList's indexOf("bar"))
	end script
	
	script |clear|
		property parent : UnitTest(me)

		set aList to collections's createArrayList()
		
		assert(aList's add("foo"), "Should have changed the list with the first item.")
		
		tell aList to clear()
		
		assertEqual(0, aList's itemCount())
		refute(aList's containsElement("foo"), "Should not contain 'foo' anymore.")
	end script
	
	script |list bullshit|
		property parent : UnitTest(me)
		
		set aList to { }
		set end of aList to "foo"
		assert(count of aList equals 1, "Should be one item in the list.")
		assert(aList contains "foo", "Should contain 'foo'.")
		
		set end of aList to "bar"		
		assert(count of aList equals 2, "Should have added a second item to the list.")
		assert(item 2 of aList equals "bar", "Bar should be the second item")
		assert(aList contains "bar", "Should have bar")
		
		refute(aList contains "sed", "sed shouldn't be there")
		
		set end of aList to "sed"
		assert(count of aList equals 3, "Should have added a third item to the list.")
		assert(item 3 of aList equals "sed", "Sed should be the third item.")
		assert(aList contains "sed", "Should have sed")
		
		set aList to rest of aList		
		assert(count of aList equals 2, "Should have two items left, but was " & count of aList )
				
		refute(aList contains "foo", "foo should be gone")
		assertEqual("bar", first item of aList)
		
--		assert(aList's listValues contains {"bar"}, "listValues should contain bar")
		assertEqual("bar", contents of first item of aList)
		assert(aList contains "bar", "Should still have 'bar'.")
		assert(item 1 of aList equals "bar", "Bar should have moved up to the first position.")
		
		assert(aList contains "sed", "Should still have 'sed'.")
		assert(item 2 of aList equals "sed", "Index of 'sed' should have changed.")		
	end script

	script |add, has, index of, remove after creating without values|
		property parent : UnitTest(me)

		set aList to collections's createArrayList()
			
		assert(aList's add("foo"), "Should have changed the list with 'foo'.")
		assert(aList's itemCount() equals 1, "Should be one item in the list.")
		assert(aList's containsElement("foo"), "Should contain 'foo'.")
		assert(aList's remove("foo"), "Should have removed 'foo'.")
		assert(aList's itemCount() equals 0, "Should have zero items in the list.")
		assert(aList's add("foo"), "Should have added 'foo' back.")
		assert(aList's itemCount() equals 1, "Should have one item back in the list.")
		
		assertEqual(1, aList's indexOf("foo"))
		assert(aList's containsElement("foo"), "foo's missing")
		
		assert(aList's add("bar"), "Should have changed the list with 'bar'.")
		assert(aList's itemCount() equals 2, "Should have added a second item to the list.")
		assertEqual(2, aList's indexOf("bar"))
		assert(aList's containsElement("bar"), "Should have bar")
		
		refute(aList's containsElement("sed"), "sed shouldn't be there")
		
		assert(aList's add("sed"), "Should have changed the list with 'sed'.")
		assert(aList's itemCount() equals 3, "Should have added a third item to the list.")
		assertEqual(3, aList's indexOf("sed"))
		assert(aList's containsElement("sed"), "Should have sed")
		
		assert(aList's remove("foo"), "Should have removed 'foo' again.")
		
		assert(aList's itemCount() equals 2, "Should have two items left, but was " & aList's itemCount() )
		
		
		refute(aList's containsElement("foo"), "foo should be gone")
--		assertEqual("bar", first item of aList's listValues)
		set values to aList's listValues
		
--		assert(aList's listValues contains {"bar"}, "listValues should contain bar")
		assertEqual("bar", contents of first item of aList's listValues)
		assert(aList's containsElement("bar"), "Should still have 'bar'.")
		assert(aList's indexOf("bar") equals 1, "Bar should have moved up to the first position.")
		
		assert(aList's containsElement("sed"), "Should still have 'sed'.")
		assert(aList's indexOf("sed") equals 2, "Index of 'sed' should have changed.")		

	end script
	
	script |test addAll, etc without existing values|
		property parent : UnitTest(me)

		set aList to collections's createArrayList()
			
		assert(aList's add("sed"), "Should have changed the list with 'sed'.")
		assert(aList's containsElement("sed"), "sed's missing")
		assertEqual(1, aList's indexOf("sed"))
		
		set newList to collections's createArrayListWithValues({"foo", "bar"})
		assert(aList's addAll(newList), "Should have changed the list with 'foo' and 'bar'.")

		assert(aList's containsElement("foo"), "foo's missing")
		assertEqual(2, aList's indexOf("foo"))
		
		assert(aList's containsElement("bar"), "bar's missing")
		assertEqual(3, aList's indexOf("bar"))
	end script
		
	script |add, has, index of, remove after creating with values|
		property parent : UnitTest(me)

		set values to {"foo", "bar"}
		set aList to collections's createArrayListWithValues(values)
			
		assert(aList's containsElement("foo"), "foo's missing")
		assertEqual(1, aList's indexOf("foo"))
		
		assert(aList's containsElement("bar"), "bar's missing")
		assertEqual(2, aList's indexOf("bar"))
		
		refute(aList's containsElement("sed"), "sed shouldn't be there")
		
		assert(aList's add("sed"), "sed should be added")
		assert(aList's containsElement("sed"), "sed's missing")
		assertEqual(3, aList's indexOf("sed"))
		
		assert(aList's remove("foo"), "Didn't remove 'foo'.")
		refute(aList's containsElement("foo"), "foo should be gone")
		assert(aList's indexOf("bar") equals 1, "Index of 'bar' should have changed.")
		assertEqual(1, aList's indexOf("bar"))
		assert(aList's indexOf("sed") equals 2, "Index of 'sed' should have changed.")		
	end script
	
end script

script |ASCollections|
	property parent : TestSet(me)
	
	on setUp()
	end setUp
	
	on tearDown()
	end tearDown
	
	
	script |test map|
		property parent : UnitTest(me)
		
		set aMap to collections's makeMap()
		
		tell aMap to putValue("a key", "a value")
		
		set kvp to aMap's getKeyValuePair("a key")
		--shouldEqual({"a key", "a value"}, kvp)
		should(aMap's containsValue("a key"), "Map should contain the value we just put in.")
		shouldEqual("a value", aMap's getValue("a key"))
		
		tell aMap to putValue("a key", "another value")
		should(aMap's containsValue("a key"), "Map should contain the new value we replaced the original with.")
		shouldEqual("another value", aMap's getValue("a key"))
		
		tell aMap to removeValue("a key")
		shouldnt(aMap's containsValue("a key"), "Map should not contain the value any more.")
	end script
	
	script |test stack - push, pop, and peek|
		property parent : UnitTest(me)
		
		set aStack to collections's makeStack()
		
		tell aStack to push("First")
		tell aStack to push("Second")
		
		shouldEqual(2, aStack's height())
		shouldEqual("Second", aStack's peek())
		shouldEqual("Second", aStack's pop())
		shouldEqual("First", aStack's pop())
		shouldEqual(0, aStack's height())
	end script
end script
