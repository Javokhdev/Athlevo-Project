DROP TRIGGER IF EXISTS trigger_update_booking_personal_access ON booking_personal;

DROP TRIGGER IF EXISTS trigger_update_booking_group_access ON booking_group;

DROP TRIGGER IF EXISTS trigger_update_booking_coach_access ON booking_coach;

DROP FUNCTION IF EXISTS update_booking_personal_access();
DROP FUNCTION IF EXISTS update_booking_group_access();
DROP FUNCTION IF EXISTS update_booking_coach_access();