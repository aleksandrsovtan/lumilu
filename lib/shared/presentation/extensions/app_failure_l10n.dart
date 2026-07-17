import '../../../core/errors/app_failure.dart';
import '../../../l10n/generated/app_localizations.dart';

extension AppFailureL10n on AppFailure {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    CameraPermissionFailure() => l10n.cameraPermissionFailure,
    MotionNotSupportedFailure() => l10n.motionNotSupportedFailure,
    MotionFailure() => l10n.motionFailure,
    UnexpectedFailure() => l10n.unexpectedFailure,
  };
}
