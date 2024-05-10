# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 optfeature

DESCRIPTION="Python wrapper of telegram bots API"
HOMEPAGE="https://docs.python-telegram-bot.org https://github.com/python-telegram-bot/python-telegram-bot"
SRC_URI="https://github.com/python-telegram-bot/python-telegram-bot/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/cachetools-5.3.3[${PYTHON_USEDEP}]
	>=dev-python/cryptography-39.0.1[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.0[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.4[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		>=dev-python/tornado-6.4[${PYTHON_USEDEP}]
	)
"

# These tests require an internet connection
EPYTEST_DESELECT=(
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_creation
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_de_json
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_expected_values
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_get_file_instance_method
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_send_animation_default_quote_parse_mode
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_send_with_animation
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_slot_behaviour
	tests/_files/test_animation.py::TestAnimationWithoutRequest::test_to_dict
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_creation
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_de_json
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_equality
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_expected_values
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_get_file_instance_method
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_send_audio_default_quote_parse_mode
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_send_with_audio
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_slot_behaviour
	tests/_files/test_audio.py::TestAudioWithoutRequest::test_to_dict
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_de_json
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_get_big_file_instance_method
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_get_small_file_instance_method
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_send_with_chat_photo
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_slot_behaviour
	tests/_files/test_chatphoto.py::TestChatPhotoWithoutRequest::test_to_dict
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_creation
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_de_json
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_equality
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_expected_values
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_get_file_instance_method
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_send_document_default_quote_parse_mode
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_send_with_document
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_slot_behaviour
	tests/_files/test_document.py::TestDocumentWithoutRequest::test_to_dict
	tests/_files/test_inputmedia.py::TestInputMediaAnimationWithoutRequest::test_with_animation
	tests/_files/test_inputmedia.py::TestInputMediaAudioWithoutRequest::test_with_audio
	tests/_files/test_inputmedia.py::TestInputMediaDocumentWithoutRequest::test_with_document
	tests/_files/test_inputmedia.py::TestInputMediaPhotoWithoutRequest::test_with_photo
	tests/_files/test_inputmedia.py::TestInputMediaVideoWithoutRequest::test_with_video
	tests/_files/test_inputmedia.py::TestSendMediaGroupWithoutRequest::test_send_media_group_default_quote_parse_mode
	tests/_files/test_inputmedia.py::TestSendMediaGroupWithoutRequest::test_send_media_group_throws_error_with_group_caption_and_individual_captions
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_creation
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_de_json
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_equality
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_expected_values
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_get_file_instance_method
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_send_photo_default_quote_parse_mode
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_send_with_photosize
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_slot_behaviour
	tests/_files/test_photo.py::TestPhotoWithoutRequest::test_to_dict
	tests/_files/test_sticker.py::TestStickerSetWithoutRequest::test_de_json
	tests/_files/test_sticker.py::TestStickerSetWithoutRequest::test_get_file_instance_method
	tests/_files/test_sticker.py::TestStickerSetWithoutRequest::test_sticker_set_to_dict
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_creation
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_de_json
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_equality
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_expected_values
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_send_sticker_default_quote_parse_mode
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_send_with_sticker
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_slot_behaviour
	tests/_files/test_sticker.py::TestStickerWithoutRequest::test_to_dict
	tests/_files/test_video.py::TestVideoWithoutRequest::test_creation
	tests/_files/test_video.py::TestVideoWithoutRequest::test_equality
	tests/_files/test_video.py::TestVideoWithoutRequest::test_expected_values
	tests/_files/test_video.py::TestVideoWithoutRequest::test_get_file_instance_method
	tests/_files/test_video.py::TestVideoWithoutRequest::test_send_video_default_quote_parse_mode
	tests/_files/test_video.py::TestVideoWithoutRequest::test_send_with_video
	tests/_files/test_video.py::TestVideoWithoutRequest::test_slot_behaviour
	tests/_files/test_video.py::TestVideoWithoutRequest::test_to_dict
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_creation
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_equality
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_expected_values
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_get_file_instance_method
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_send_video_note_default_quote_parse_mode
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_send_with_video_note
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_slot_behaviour
	tests/_files/test_videonote.py::TestVideoNoteWithoutRequest::test_to_dict
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_creation
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_equality
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_expected_values
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_get_file_instance_method
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_send_voice_default_quote_parse_mode
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_send_with_voice
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_slot_behaviour
	tests/_files/test_voice.py::TestVoiceWithoutRequest::test_to_dict
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_after_shutdown
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_exceptions
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_manual_timeouts
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_params_no_data
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_params_with_data
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_do_request_return_value
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_http_1_response
	tests/request/test_request.py::TestHTTPXRequestWithoutRequest::test_multiple_init_cycles
	tests/request/test_request.py::TestRequestWithoutRequest::test_chat_migrated
	tests/request/test_request.py::TestRequestWithoutRequest::test_error_description
	tests/request/test_request.py::TestRequestWithoutRequest::test_exceptions_in_do_request
	tests/request/test_request.py::TestRequestWithoutRequest::test_illegal_json_response
	tests/request/test_request.py::TestRequestWithoutRequest::test_replaced_unprintable_char
	tests/request/test_request.py::TestRequestWithoutRequest::test_retrieve
	tests/request/test_request.py::TestRequestWithoutRequest::test_retry_after
	tests/request/test_request.py::TestRequestWithoutRequest::test_special_errors
	tests/request/test_request.py::TestRequestWithoutRequest::test_timeout_propagation
	tests/request/test_request.py::TestRequestWithoutRequest::test_unknown_request_params
	tests/test_bot.py::TestBotWithoutRequest::test_bot_method_logging
	tests/test_bot.py::TestBotWithoutRequest::test_copy_message
	tests/test_bot.py::TestBotWithoutRequest::test_equality
	tests/test_bot.py::TestBotWithoutRequest::test_get_me_and_properties
	tests/test_bot.py::TestBotWithoutRequest::test_log_decorator
	tests/test_bot.py::TestBotWithoutRequest::test_send_message_default_quote_parse_mode
	tests/test_forum.py::TestForumTopicCreatedWithoutRequest::test_equality
	tests/test_forum.py::TestForumTopicWithoutRequest::test_de_json
	tests/test_forum.py::TestForumTopicWithoutRequest::test_equality
	tests/test_forum.py::TestForumTopicWithoutRequest::test_expected_values
	tests/test_forum.py::TestForumTopicWithoutRequest::test_slot_behaviour
	tests/test_forum.py::TestForumTopicWithoutRequest::test_to_dict
)

distutils_enable_tests pytest

# Run only the tests that don't require a connection
python_test() {
	epytest -m no_req
}

pkg_postinst() {
	optfeature "using telegram.ext.JobQueue" dev-python/APScheduler
}
