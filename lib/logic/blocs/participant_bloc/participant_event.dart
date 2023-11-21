part of 'participant_bloc.dart';

abstract class ParticipantEvent extends Equatable{
  const ParticipantEvent();

  @override
  List<Object> get props => [];
}

class LeaveHoliday extends ParticipantEvent {
  final Holiday holiday;

  const LeaveHoliday({required this.holiday});

  @override
  List<Object> get props => [holiday];
}

class GetAllParticipantNotYetInHoliday extends ParticipantEvent {
  final String holidayId;

  const GetAllParticipantNotYetInHoliday({required this.holidayId});

  @override
  List<Object> get props => [holidayId];
}

class GetAllParticipantNotYetInActivity extends ParticipantEvent {
  final String activityId;

  const GetAllParticipantNotYetInActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}