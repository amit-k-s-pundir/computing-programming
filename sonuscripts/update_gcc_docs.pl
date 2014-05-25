


my $gcc_version = shift or $gcc_version = "4.7";
my $gcc_doc_url_common =
    "http://gcc.gnu.org/onlinedocs/gcc-4.7.0/gcc/";

my %gcc_docs_urls = (gcc_manual => ${gcc_doc_url_common}/gcc.pdf,
                     gcc_cpp_manual => ${gcc_doc_url_common}/cpp.pdf,
                     gcc_std_cpp_manual =>
                     ${gcc_doc_url_common}/libstdc++/libstdc++-manual.pdf.bz2,
                     gcc_std_cpp_ref_manual =>
                     ${gcc_doc_url_common}/libstdc++/libstdc++-api.pdf.bz2,
                     gcc_std_cpp_ref_manual_html =>
                     ${gcc_doc_url_common}/libstdc++/libstdc++-api.html.tar..bz2,
                     gcc_std_cpp_manual_html =>
                     ${gcc_doc_url_common}/libstdc++/libstdc++-manual.tar.html.bz2);

with_dir($gcc_doc_dir, sub{
         while (my($key, $val) = each(%gcc_docs_urls)) {
     });
#wget -N -c http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc.pdf
#wget -N -c http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc-html.tar.gz
