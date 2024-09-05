CREATE TRIGGER trigger_update_booking_personal_access_for_access
BEFORE INSERT OR UPDATE ON access_personal
FOR EACH ROW EXECUTE PROCEDURE update_booking_personal_access();

CREATE TRIGGER trigger_update_booking_group_access_for_access
BEFORE INSERT OR UPDATE ON access_group
FOR EACH ROW EXECUTE PROCEDURE update_booking_group_access();

CREATE TRIGGER trigger_update_booking_coach_access_for_access
BEFORE INSERT OR UPDATE ON access_coach
FOR EACH ROW EXECUTE PROCEDURE update_booking_coach_access();