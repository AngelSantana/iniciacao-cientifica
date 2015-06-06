#!/usr/bin/perl

use Person;

$object = new Person();#Pode passar pelo construtor
# Get first name which is set using constructor.
$object->setLastName("Silva");
$firstName = $object->getFirstName();

print "Before Setting First Name is : $firstName\n";

$lastName = $object->getLastName();

print "Last Name is : $lastName \n";

# Now Set first name using helper function.
$object->setFirstName( "Mohd." );

# Now get first name set by helper function.
$firstName = $object->getFirstName();
print "Before Setting First Name is : $firstName\n";

