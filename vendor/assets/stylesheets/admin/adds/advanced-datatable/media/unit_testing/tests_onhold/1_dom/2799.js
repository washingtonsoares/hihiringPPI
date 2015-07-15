// DATA_TEMPLATE: two_tables
oTest.fnStart( "Initialise two table" );

$(document).ready( function () {
	$('table.display').dataTable();
	
	oTest.fnTest( 
		"Check that initialisation was okay",
		null,
		function () { return true; }
	);
	
	oTest.fnComplete();
} );