
use Encode;
use JSON;

package xResponse;
sub new
{
    my $class = shift;
    my $self = {
        HasErrors   => shift,
        ErrorCode   => shift,
        Message     => shift,
    };
    
    bless $self, $class;
    return $self;
}

sub set
{
    my($self, $errors, $errorcode, $message) = @_;
    
    $self->{HasErrors} = $errors;
    $self->{ErrorCode} = $errorcode;
    $self->{Message} = $message;
}


sub send
{
    my($self, $socket) = @_;
    
    my $json = encode_json($self);
    my $len = pack("I", length(Encode::encode_utf8($json)));
    
    return $socket->send($len . $json) > 0;    
}

1;

__END__
