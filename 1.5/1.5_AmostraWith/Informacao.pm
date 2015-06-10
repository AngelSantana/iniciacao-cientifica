package Informacao;
use Moose;
use strict;
use warnings;



 # has 'message' => (
      # is      => 'rw',
      # isa     => 'Str',
      # default => 'Hello, I am a Foo'
  # );
  
   has 'termo' => (
      is      => 'rw',
      isa     => 'Str',      
  );
  
 has 'posicao' => (
      is      => 'rw',
      isa     => 'Int',      
  );

 has 'valor' => (
      is      => 'rw',
      isa     =>  'Value',      
  );
  
 has 'nomeDocumento' => (
      is      => 'rw',
      isa     => 'Str',      
  );  
  
   has 'indexSinonimos' => (
      is      => 'rw',
      isa     => 'Str',      
  );  
  
   has 'posicaoDocumento' => (
      is      => 'rw',
      isa     => 'Int',      
  );  

1; 