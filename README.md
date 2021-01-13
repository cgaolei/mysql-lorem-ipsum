# MySQL Lorem Ipsum Function

## About Lorem Ipsum
https://en.wikipedia.org/wiki/Lorem_ipsum
https://www.lipsum.com/

## Setup
#### Download
```shell
wget https://raw.githubusercontent.com/cgaolei/mysql-lorem-ipsum/main/mysql/lipsum.sql
```
Or (if `wget` unavailable on the server)
```shell
curl https://raw.githubusercontent.com/cgaolei/mysql-lorem-ipsum/main/mysql/lipsum.sql -o lipsum.sql
```
#### Installation
```shell
mysql -u user -p MY_DATABASE < lipsum.sql
```

## Usage & Examples

#### Syntax
```
lipsum(p_min_words, p_max_words, p_start_with_lipsum, p_rand_seed)
```

#### "Deterministic"
```mysql
MySQL [MY_DATABASE]> select lipsum(5,15,false,100) as Text;
+---------------------------------------------------+
| Text                                              |
+---------------------------------------------------+
| Lacus penatibus ultrices dapibus lacus penatibus. |
+---------------------------------------------------+
1 row in set (0.00 sec)

MySQL [MY_DATABASE]> select lipsum(5,15,false,100) as Text;
+---------------------------------------------------+
| Text                                              |
+---------------------------------------------------+
| Lacus penatibus ultrices dapibus lacus penatibus. |
+---------------------------------------------------+
1 row in set (0.00 sec)
```
```mysql
MySQL [MY_DATABASE]> select lipsum(5,15,false,200) as Text;
+-------------------------------------------+
| Text                                      |
+-------------------------------------------+
| Leo phasellus ut dignissim leo phasellus. |
+-------------------------------------------+
1 row in set (0.00 sec)
```

#### Random text
```mysql
MySQL [MY_DATABASE]> select lipsum(5,15,false,NULL) as Text;
+----------------------------------------------------------------------------------------------------+
| Text                                                                                               |
+----------------------------------------------------------------------------------------------------+
| Class eleifend tempor placerat sollicitudin cursus et tempor natoque. Habitant consequat nascetur. |
+----------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```
```mysql
MySQL [MY_DATABASE]> select lipsum(5,15,false,NULL) as Text;
+----------------------------------------------------------------+
| Text                                                           |
+----------------------------------------------------------------+
| Natoque magnis quis fames eros interdum egestas tortor sociis. |
+----------------------------------------------------------------+
1 row in set (0.00 sec)
```
```mysql
MySQL [MY_DATABASE]> select lipsum(5,15,false,NULL) as Text;
+--------------------------------------------------------------------------------------------+
| Text                                                                                       |
+--------------------------------------------------------------------------------------------+
| Amet molestie metus volutpat laoreet curabitur malesuada a montes. Sed vitae magna luctus. |
+--------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

```

## Credits
This function was modified based on this gist here:
https://gist.github.com/zackad/461548a4a701ca93ada5e009f57a79d1

This text was extracted from the `fn_str_random_lipsum.sql` file:
```
/**
* ALL CREDIT GOES TO ORIGINAL CREATOR
* @Ronald Speelman
* http://moinne.com/blog/ronald/mysql/mysql-lorum-ipsum-generator
*
* renamed function for simplicity
*/
```
* The original creator's blog `http://moinne.com/blog/ronald` was no longer available at the time.
* Feature added to return a "deterministric" text for the same given inputs.
* Changed the order of function's parameters to have the `p_min_words` as first.