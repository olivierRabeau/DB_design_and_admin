--Requires to be connected with "sa" login 
--or USR_administrator if database has been migrated to partially contained

USE cinema_booking_db;
GO

BEGIN TRY

    INSERT INTO S_programming.T_movies (movie_title, movie_gender, movie_director, movie_actors,
    movie_synopsis, movie_duration_minutes)
    VALUES (N'Novembre', N'thriller', N'Cédric Jimenez', 
    N'Jean Dujardin, Anaïs Demoustier, Sandrine Kiberlain, Jérémie Renier, Lyna Khoudri',
    N'Une plongée au cœur de l’Anti-Terrorisme pendant les 5 jours d’enquête 
    qui ont suivi les attentats du 13 novembre.', 107),
    (N'Kompromat', N'Thriller', N'Jérôme Salle', N'Gilles Lellouche, Joanna Kulig, 
    Louis-do De Lencquesaing, Michael Gor, Aleksey Gorbunov', N'Russie, 2017. 
    Mathieu Roussel est arrêté et incarcéré sous les yeux de sa fille. 
    Expatrié français, il est victime d’un « kompromat », de faux documents 
    compromettants utilisés par les services secrets russes pour nuire 
    à un ennemi de l’Etat. Menacé d une peine de prison à vie, il ne lui reste 
    qu une option : s’évader, et rejoindre la France par ses propres moyens…',127),
    (N'Jumeaux mais pas trop', N'Comédie', N'Olivier Ducray, Wilfried Meance', 
    N'Ahmed Sylla, Bertrand Usclat, Pauline Clément, Gérard Jugnot, Isabelle Gélinas',
    N'33 ans après leur naissance, deux frères jumeaux découvrent soudainement 
    l’existence l’un de l’autre... Pour Grégoire et Anthony, la surprise est 
    d’autant plus grande que l’un est blanc, l’autre noir ! 
    Il y avait une chance sur un million que ce phénomène génétique survienne. 
    Mais leur couleur de peau est loin d’être la seule chose qui les différencie ! 
    En faisant connaissance, aucun des deux n’a l’impression d’avoir tiré le gros lot…',108),
    (N'Halloween ends', N'Epouvante', N'David Gordon Green', N'Jamie Lee Curtis, Andi Matichak, Rohan Campbell',
    N'Quatre ans après les événements d’Halloween Kills, Laurie vit désormais 
    avec sa petite-fille Allyson et achève d’écrire ses mémoires. Michael Myers ne 
    s’est pas manifesté ces derniers temps...',111),
    (N'Samourai academy', N'Animation', N'Rob Minkoff, Mark Koetsier, Chris Bailey', N'', 
    N'Hank est un chien enjoué qui rêve d’être samouraï dans un monde où ce privilège 
    n’est réservé… qu’aux chats ! Moqué, refusé par toutes les écoles de samouraïs, 
    il rencontre un gros matou grincheux, un maître guerrier qui finit par accepter 
    de lui enseigner les techniques ancestrales des samouraïs.',97),
    (N'Le Petit Nicolas', N'Animation', N'Amandine Fredon, Benjamin Massoubre', 
    N'Laurent Lafitte, Alain Chabat, Simon Faliu, Marc Arnaud', 
    N'Penchés sur une large feuille blanche, Sempé et Goscinny donnent vie 
    à un petit garçon rieur et malicieux, le Petit Nicolas. Au fil du récit, 
    le garçon se glisse dans l’atelier de ses créateurs, et les interpelle avec drôlerie.', 82),
    (N'Simone le voyage du siècle', N'Biopic', N'Olivier Dahan', N'Elsa Zylberstein, Rebecca Marder, Élodie Bouchez',
    N'Le destin de Simone Veil, son enfance, ses combats politiques, ses tragédies. 
    Le portrait épique et intime d’une femme au parcours hors du commun 
    qui a bousculé son époque en défendant un message humaniste toujours 
    d’une brûlante actualité.', 140),
    (N'Dragon Ball Super: Super Hero', N'Animation', N'Tetsuro Kodama', N'Bin Shimada, Koichi Yamadera, Miyu Irino',
    N'L’armée du Ruban Rouge avait été détruite par Son Goku, mais des individus 
    ont décidé de la faire renaître. Ils ont ainsi créé les cyborgs ultimes, 
    Gamma 1 et Gamma 2. Autoproclamés les « Super Héros », ils lancent une attaque 
    contre Piccolo et Son Gohan.', 100),
    (N'Butterfly vision', N'Drame', N'Maksym Nakonechnyi', N'Rita Burkovska, Lyubomyr Valivots, Myroslava Vytrykhoska-Makar',
    N'Lilia, une spécialiste en reconnaissance aérienne, retourne auprès de sa famille 
    en Ukraine après plusieurs mois passés en prison dans le Donbass. 
    Le traumatisme de la captivité la tourmente et refait surface sous forme de visions. 
    Mais elle refuse de se voir comme une victime et se bat pour se libérer.', 107),
    (N'Black Adam', N'Fantastique', N'Jaume Collet-Serra', N'Dwayne Johnson, Aldis Hodge, Pierce Brosnan',
    N'Près de cinq millénaires après avoir reçu les super-pouvoirs des anciens dieux 
    – et avoir été emprisonné dans la foulée –, Black Adam est libéré de sa tombe 
    terrestre, prêt à exercer sa propre justice dans le monde moderne…', 125),
    (N'Beast', N'Action, Thriller, Drame', N'Baltasar Kormákur', N'Idris Elba, Sharlto Copley, Iyana Halley',
    N'Le Dr. Nate Daniels revient en Afrique du Sud pour y passer des vacances avec 
    ses deux filles dans une réserve naturelle. Mais ce repos va se transformer 
    en épreuve de survie quand un lion assoiffé de vengeance se met à dévorer 
    tout humain sur sa route.', 93),
    (N'Le sixième enfant', N'Drame', N'Léopold Legrand', N'Sara Giraudeau, Benjamin Lavernhe, Judith Chemla', 
    N'Franck, ferrailleur, et Meriem ont cinq enfants, un sixième en route, et de sérieux problèmes d’argent. 
    Julien et Anna sont avocats et n’arrivent pas à avoir d’enfant. 
    C’est l’histoire d’un impensable arrangement.', 95);

    INSERT INTO S_management.T_complexes (complex_name, complex_address, complex_town, complex_phone, complex_email)
    VALUES 
    (N'UGC Ciné Cité Paris 19', N'166 Boulevard Macdonald à Paris (19ème arrondissement)', N'Paris', N'+330176647997', N'cine-cite-paris@ugc.com'),
    (N'UGC Ciné Cité Strasbourg', N'25, avenue du Rhin 67100 STRASBOURG', N'Strasbourg', N'+330146372824', N'cine-cite-strasbourg@ugc.com'),
    (N'UGC Ciné Cité Internationale', N'Cité Internationale - 80, quai Charles de Gaulle 69006 LYON', N'Lyon', N'+330146372824', N'cine-cite-lyon@ugc.com');

    INSERT INTO S_management.T_rooms (room_number, room_seats, room_complex)
    VALUES 
    (1,188,1),(2,380,1),(3,240,1),(4,160,1),(5,320,1),(6,212,1),(7,360,1),(8,220,1),(9,120,1),(10,140,1),
    (1,200,2),(2,170,2),(3,220,2),(4,190,2),(5,110,2),(6,300,2),(7,250,2),(8,280,2),(9,130,2),(10,212,2),(11,156,2),
    (1,180,3),(2,150,3),(3,200,3),(4,260,3),(5,180,3),(6,290,3),(7,182,3),(8,330,3),(9,228,3),(10,148,3),(11,264,3),(12,146,3);

    INSERT INTO S_management.T_roles (role_name)
    VALUES 
    (N'Administrateur'), 
    (N'Programmeur'), 
    (N'projectioniste'), 
    (N'guichetier');

    INSERT INTO S_management.T_employees (employee_name, employee_firstname, employee_address,
    employee_phone,	employee_email,	employee_complex, employee_role)
    VALUES 
    (N'Lawrence', N'Jennifer', N'609 North Ocean Drive, Hollywood, FL 33019, États-Unis', N'0143264826', N'j.lawrence@actress.com', 1, 1),
    (N'Knightley', N'Keira', N'1000 South Federal Highway, Hallandale Beach, Hollywood, FL 33009, États-Unis', N'0143310107', N'k.knightley@actress.com', 2, 1),
    (N'Bekhti', N'Leila', N'609 North Ocean Drive, Hollywood, FL 33019, États-Unis', N'0144720605', N'e.blunt@actress.com', 3, 1),
    (N'Blunt', N'Emily', N'5101 Hollywood Boulevard, Hollywood, FL 33021, États-Unis', N'0153328529', N'l.bekhti@actress.com', 1, 2),
    (N'Freeman', N'Morgan', N'334 Arizona Street, Hollywood, FL 33019, États-Unis', N'0145089389', N'c.eastwood@actor.com', 2, 2), 
    (N'De Niro', N'Robert', N'2601 North 29th Avenue, Hollywood, FL 33020, États-Unis', N'0148009024', N'r.de-niro@actor.com', 3, 2), 
    (N'Eastwood', N'Clint', N'1000 North Surf Road, Hollywood, FL 33010, États-Unis', N'0171193333', N'm.freeman@actor.com', 1, 3), 
    (N'Hardy', N'Tom', N'1915 North Ocean Drive, Hollywood, FL 33019, États-Unis', N'0185080950', N't.hardy@actor.com', 2, 3), 
    (N'L. Jackson', N'Samuel', N'11 West 37th St, New York, NY 10018, États-Unis', N'0143226535', N's.l-jackson@actor.com', 3, 3), 
    (N'Bale', N'Christian', N'36 Central Park South, New York, NY 10019, États-Unis', N'0153447979', N'c.bale@actor.com', 1, 4), 
    (N'Gyllenhaal', N'Jake', N'400 West 42nd Street, Hell’s Kitchen, New York, NY 10036, États-Unis', N'0145405726', N'j.gyllenhaal@actor.com', 2, 4), 
    (N'Del Toro', N'Benicio', N'44 West 44th Street, New York, NY 10036, États-Unis', N'0148000450', N'b.del-toro@actor.com', 3, 4);

    INSERT INTO S_accounting.T_prices (price_category, price_amount_euros)
    VALUES 
    (N'Plein tarif', 9.20), 
    (N'Étudiant', 7.60), 
    (N'Moins de 14 ans', 5.90);

    INSERT INTO S_accounting.T_reductions (reduction_category, reduction_amount_euros)
    VALUES 
    (N'Fête du cinéma', 2), 
    (N'Resto plus cinéma', 1.5), 
    (N'Semaine', 1);

    INSERT INTO S_programming.T_movies_screenings (mvscr_date_time_group,
    mvscr_movie, mvscr_room)
    VALUES 
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 1, 1),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 1, 2),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 2, 3),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'21:00:00'), 2, 3),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'23:00:00'), 2, 3),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 3, 4),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 4, 5),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:30:00'), 4, 5),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'22:00:00'), 4, 5),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 5, 6),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 6, 7),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'21:00:00'), 6, 7),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 7, 8),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 8, 9),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:00:00'), 9, 10),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:00:00'), 10, 11),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:30:00'), 11, 12),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:30:00'), 12, 13),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:30:00'), 1, 14),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:30:00'), 2, 15),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'21:30:00'), 2, 15),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:30:00'), 4, 16),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:00:00'), 4, 16),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'21:30:00'), 4, 16),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 7, 17),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'15:00:00'), 8, 18),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'15:00:00'), 9, 19),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'15:00:00'), 10, 20),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'15:00:00'), 11, 21),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'15:30:00'), 12, 22),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'17:00:00'), 1, 23),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:00:00'), 2, 24),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'17:30:00'), 3, 25),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'17:00:00'), 4, 26),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:30:00'), 4, 26),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:00:00'), 5, 27),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'19:00:00'), 6, 28),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:00:00'), 7, 29),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'18:30:00'), 8, 30),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:00:00'), 9, 31),
    (CONCAT_WS (' ', FORMAT(CURRENT_TIMESTAMP,'dd-MM-yyyy'),'20:30:00'), 10, 32);

    INSERT INTO S_reception.T_customers (customer_name,	customer_firstname,	customer_phone,	customer_email)
    VALUES
    (N'Martin', N'Emma', N'0125689745', N'emma.martin@yahoo.fr'),
    (N'Dubois', N'Lola', N'0136984230', N'lola-dubois@gmail.com'),
    (N'Collet', N'Nathan', N'0173298416', N'nathan_collet@msn.com'),
    (N'Prevost', N'Lucas', N'0177965533', N'lucas_prevost@orange.fr'),
    (N'Joly', N'Suzanne', N'0125689745', N'suzanne.joly@sfr.fr');

    INSERT INTO S_reception.T_reservations (reservation_customer, reservation_mvscr, reservation_price,	reservation_reduction)
    VALUES
    (1, 10, 1, NULL), (1, 10, 1, NULL), (1, 10, 3, NULL), (1, 10, 3, NULL), (2, 1, 2, NULL), (2, 1, 2, NULL), (3, 28, 3, 1), (3, 28, 3, 1),
    (4, 6, 1, 2), (4, 6, 1, 2), (4, 6, 2, 2), (4, 6, 3, 2), (5, 15, 1, 3), (5, 15, 1, 3);
 
END TRY
BEGIN CATCH
END CATCH


--Feeding table S_accounting.T_invoices

DECLARE reservation_cursor CURSOR FOR  
SELECT
		reservation_customer,
    	reservation_mvscr
FROM S_reception.T_reservations
GROUP BY reservation_customer, reservation_mvscr;
  
OPEN reservation_cursor;  

DECLARE @customer_id INT;  
DECLARE @mvscr_id INT;  

-- Perform the first fetch.  
FETCH NEXT FROM reservation_cursor  
INTO @customer_id, @mvscr_id;  
  
-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN     
    EXEC S_accounting.P_create_invoice @customer_id, @mvscr_id;
    FETCH NEXT FROM reservation_cursor  
    INTO @customer_id, @mvscr_id;   
END  
  
CLOSE reservation_cursor;  
DEALLOCATE reservation_cursor;  
GO  
