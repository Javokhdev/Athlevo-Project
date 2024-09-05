CREATE OR REPLACE FUNCTION update_booking_personal_access()
RETURNS TRIGGER AS $$
DECLARE
  subscription_duration INT;
  subscription_count INT;
  access_count INT;
  booking_start_date TIMESTAMP;
BEGIN
  -- Get the subscription duration and count
  SELECT duration, count INTO STRICT subscription_duration, subscription_count
  FROM subscription_personal
  WHERE id = NEW.subscription_id;

  -- Get the access count
  SELECT COUNT(*) INTO access_count
  FROM access_personal
  WHERE booking_id = NEW.id;

  -- Get the booking start date
  booking_start_date := NEW.start_date;

  -- Check all conditions
  IF NEW.payment >= (SELECT price FROM subscription_personal WHERE id = NEW.subscription_id) AND 
     booking_start_date >= NOW() AND 
     (booking_start_date + (subscription_duration * INTERVAL '1 day') > NOW()) AND
     (NEW.count = -1 OR access_count < subscription_count) THEN
    -- Update access_status to 'granted'
    NEW.access_status := 'granted';
  ELSE
    -- Update access_status to 'denied'
    NEW.access_status := 'denied';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_update_booking_personal_access
BEFORE INSERT OR UPDATE ON booking_personal
FOR EACH ROW EXECUTE PROCEDURE update_booking_personal_access();

CREATE OR REPLACE FUNCTION update_booking_group_access()
RETURNS TRIGGER AS $$
DECLARE
  subscription_duration INT;
  subscription_count INT;
  access_count INT;
  booking_start_date TIMESTAMP;
BEGIN
  -- Get the subscription duration and count
  SELECT duration, count INTO STRICT subscription_duration, subscription_count
  FROM subscription_group
  WHERE id = NEW.subscription_id;

  -- Get the access count
  SELECT COUNT(*) INTO access_count
  FROM access_group
  WHERE booking_id = NEW.id;

  -- Get the booking start date
  booking_start_date := NEW.start_date;

  -- Check all conditions
  IF NEW.payment >= (SELECT price FROM subscription_group WHERE id = NEW.subscription_id) AND 
     booking_start_date >= NOW() AND 
     (booking_start_date + (subscription_duration * INTERVAL '1 day') > NOW()) AND
     (NEW.count = -1 OR access_count < subscription_count) THEN
    -- Update access_status to 'granted'
    NEW.access_status := 'granted';
  ELSE
    -- Update access_status to 'denied'
    NEW.access_status := 'denied';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_booking_group_access
BEFORE INSERT OR UPDATE ON booking_group
FOR EACH ROW EXECUTE PROCEDURE update_booking_group_access();


CREATE OR REPLACE FUNCTION update_booking_coach_access()
RETURNS TRIGGER AS $$
DECLARE
  subscription_duration INT;
  booking_start_date TIMESTAMP;
BEGIN
  -- Get the subscription duration
  SELECT duration INTO STRICT subscription_duration
  FROM subscription_coach
  WHERE id = NEW.subscription_id;

  -- Get the booking start date
  booking_start_date := NEW.start_date;

  -- Check if payment is sufficient, booking is within the valid period, and start_date is in the future
  IF NEW.payment >= (SELECT price FROM subscription_coach WHERE id = NEW.subscription_id) AND 
     (booking_start_date + (subscription_duration * INTERVAL '1 hour') > NOW()) AND
     booking_start_date > NOW() THEN
    -- Update access_status to 'granted'
    NEW.access_status := 'granted';
  ELSE
    -- Update access_status to 'denied'
    NEW.access_status := 'denied';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_booking_coach_access
BEFORE INSERT OR UPDATE ON booking_coach
FOR EACH ROW EXECUTE PROCEDURE update_booking_coach_access();