SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DELIMITER //
DROP FUNCTION IF EXISTS lipsum;
//

CREATE FUNCTION lipsum(
 p_min_words SMALLINT,
 p_max_words SMALLINT,
 p_start_with_lipsum TINYINT(1),
 p_rand_seed BIGINT
)
RETURNS VARCHAR(10000)
NO SQL
BEGIN
    /**
    * version: 1.1.0
    * For latest updates and issues:
    *   https://github.com/cgaolei/mysql-lorem-ipsum
    *
    * %param p_min_words         Number: the minimum amount of words in the
    *                                    result, By providing the parameter, you provide a range
    *                                    Default = 0
    *
    * %param p_max_words         Number: the maximum amount of words, if no
    *                                    min_words are provided this will be the
    *                                    exact amount of words in the result
    *                                    Default = 50
    *
    * %param p_start_with_lipsum Boolean:if "1" the string will start with
    *                                    'Lorum ipsum dolor sit amet.', Default = 0
    *
    * %param p_rand_seed         Number: a seed for the RAND() function. If the seed value is non-NULL,
    *                                    then the output text is "deterministic" for the same given input parameters.
    *                                    Otherwise, the output text is random
    *                                    Default = NULL
    * %return String
    */

    DECLARE v_max_words SMALLINT DEFAULT 50;
    DECLARE v_random_item SMALLINT DEFAULT 0;
    DECLARE v_random_word VARCHAR(25) DEFAULT '';
    DECLARE v_start_with_lipsum TINYINT DEFAULT 0;
    DECLARE v_result VARCHAR(10000) DEFAULT '';
    DECLARE v_iter INT DEFAULT 1;
    DECLARE v_text_lipsum VARCHAR(1500) DEFAULT 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate';
    DECLARE v_text_lipsum_wordcount INT DEFAULT 180;
    DECLARE v_sentence_wordcount INT DEFAULT 0;
    DECLARE v_sentence_start BOOLEAN DEFAULT 1;
    DECLARE v_sentence_end BOOLEAN DEFAULT 0;
    DECLARE v_sentence_lenght TINYINT DEFAULT 9;
    DECLARE v_rand_seed BIGINT DEFAULT NULL;

    SET v_max_words := COALESCE(p_max_words, v_max_words);
    SET v_start_with_lipsum := COALESCE(p_start_with_lipsum , v_start_with_lipsum);
    SET v_rand_seed := COALESCE(p_rand_seed, v_rand_seed);

    IF p_min_words IS NOT NULL THEN
        SET v_max_words := FLOOR(p_min_words + (IF(v_rand_seed IS NULL, RAND(), RAND(v_rand_seed)) * (v_max_words - p_min_words)));
        SET v_rand_seed := IF(v_rand_seed IS NULL, NULL, v_rand_seed+1);
    END IF;

    IF v_max_words < v_sentence_lenght THEN
        SET v_sentence_lenght := v_max_words;
    END IF;

    IF p_start_with_lipsum = 1 THEN
        SET v_result := CONCAT(v_result,'Lorem ipsum dolor sit amet.');
        SET v_max_words := v_max_words - 5;
    END IF;

    WHILE v_iter <= v_max_words DO
            SET v_random_item := FLOOR(1 + (IF(v_rand_seed IS NULL, RAND(), RAND(v_rand_seed)) * v_text_lipsum_wordcount));
            SET v_rand_seed := IF(v_rand_seed IS NULL, NULL, v_rand_seed+1);
            SET v_random_word := REPLACE(SUBSTRING(SUBSTRING_INDEX(v_text_lipsum, ' ' ,v_random_item),
                                                   CHAR_LENGTH(SUBSTRING_INDEX(v_text_lipsum,' ', v_random_item -1)) + 1),
                                         ' ', '');

            SET v_sentence_wordcount := v_sentence_wordcount + 1;
            IF v_sentence_wordcount = v_sentence_lenght THEN
                SET v_sentence_end := 1 ;
            END IF;

            IF v_sentence_start = 1 THEN
                SET v_random_word := CONCAT(UPPER(SUBSTRING(v_random_word, 1, 1)),LOWER(SUBSTRING(v_random_word FROM 2)));
                SET v_sentence_start := 0 ;
            END IF;

            IF v_sentence_end = 1 THEN
                IF v_iter <> v_max_words THEN
                    SET v_random_word := CONCAT(v_random_word, '.');
                END IF;
                SET v_sentence_lenght := FLOOR(9 + (IF(v_rand_seed IS NULL, RAND(), RAND(v_rand_seed)) * 7));
                SET v_rand_seed := IF(v_rand_seed IS NULL, NULL, v_rand_seed+1);
                SET v_sentence_end := 0 ;
                SET v_sentence_start := 1 ;
                SET v_sentence_wordcount := 0 ;
            END IF;

            SET v_result := CONCAT(v_result,' ', v_random_word);
            SET v_iter := v_iter + 1;
        END WHILE;

    RETURN TRIM(CONCAT(v_result,'.'));
END;
//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;