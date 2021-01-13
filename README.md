# mysql-lorem-ipsum

### Setup
```shell
mysql -u user -p MY_DATABASE < lipsum.sql
```

### Examples

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