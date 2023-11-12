import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/repositories/invtation_api_repository.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final InvitationApiRepository invitationApiRepository = InvitationApiRepository();

  InvitationBloc() : super(InvitationState()) {

    on<CreateInvitations>((event, emit) async {
      try {
        final List<Participant> participants = event.participants;
        final holidayId = event.holidayId;

        await invitationApiRepository.createInvitations(participants, holidayId);

      } on ApiException catch (e) {
        emit(state.copyWith(errorMessage : e.toString()));
      }
    });

    on<GetAllInvitationsByParticipant>((event, emit) async {
      try {
        emit(state.copyWith(status: InvitationStateStatus.loading));

        final participantId = event.participantId;
        final invitationsList = await invitationApiRepository.getAllInvitationsByParticipant(participantId);

        emit(state.copyWith(status: InvitationStateStatus.loaded, invitationsList: invitationsList));

      } on ApiException catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    });

    on<AcceptInvitation>((event, emit) async {
      try {
        final invitation = event.invitation;

        await invitationApiRepository.acceptInvitation(invitation);

      } on ApiException catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    });

    on<RefuseInvitation>((event, emit) async {
      try {
        final invitation = event.invitation;

        await invitationApiRepository.refuseInvitation(invitation);

      } on ApiException catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    });

  }
}