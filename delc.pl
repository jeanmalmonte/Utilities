#!/usr/bin/perl -w
# Program to safely ask user if they want to delete their directory

if (@ARGV)
{
    @file_list= @ARGV;
}
else {
    print ("ERROR: no args\n");
    exit 1;
}
$argument = @file_list[0];

if (index($argument, "*") != 1) {
    @file_list = glob($argument);

}

foreach $l (@file_list) { 
    
    opendir(DIRHANDLE, $l);

    while (readdir(DIRHANDLE)) {
        chomp();
        if ($_ eq "." || $_ eq "..") {
                next;
        }
        if ( (-f $_) ) {
            print ("delete? [y, q] file: $_ : ");
            $dirDel = <STDIN>;
            chomp ($dirDel);
        
            if ($dirDel eq "q" || $dirDel eq "Q") {
                print ("Exiting program...\n");
                exit 0;
            } 
            elsif ($dirDel eq "y") {
                push @dl, "$_ ";
            }
            else {
                print ("Invalid option. Exiting program...");
                exit 0;
            }  

        }
        else {
            print ("delete? [y, q] dir: $_ : ");
            $dirDel = <STDIN>;
            chomp ($dirDel);
            if ($dirDel eq "q" || $dirDel eq "Q") {
                print ("Exiting program..\n");
                exit 0;
            }
            elsif ($dirDel eq "y" || $dirDel eq "Y") {
                push @dl, "$_ ";
            }
            else {
                print "Invalid option. Exiting program...\n";
                exit 0;
            }
        }
    }
 closedir(DIRHANDLE);
}

print("complete all deletions [y, n]: ");
$input = <STDIN>;
chomp($input);
if ($input eq "y" || $input eq "Y") {
    print "Delete files later...\n";
    exit 0;
}

else {
    print ("Nothing was deleted.\n");
    exit 0;
}
