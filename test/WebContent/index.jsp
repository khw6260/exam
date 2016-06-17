<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='/test/fullcalendar-2.7.3/lib/cupertino/jquery-ui.min.css' />
<link href='/test/fullcalendar-2.7.3/fullcalendar.css' rel='stylesheet' />
<link href='/test/fullcalendar-2.7.3/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='/test/fullcalendar-2.7.3/lib/moment.min.js'></script>
<script src='/test/fullcalendar-2.7.3/lib/jquery.min.js'></script>
<script src='/test/fullcalendar-2.7.3/fullcalendar.min.js'></script>
<script src='/test/fullcalendar-2.7.3/lang-all.js'></script>
<script>

	$(document).ready(function() {
		
		function ShowEventPopup(date) {
		    //ClearPopupFormValues();
		    $('#popupEventForm').show();
		    $('#eventTitle').focus();
		}
		$('#btnPopupSave').click(function () {
		    $('#popupEventForm').hide();
		    /* var dataRow = {
		        'Title':$('#eventTitle').val(),
		        'NewEventDate': $('#eventDate').val(),
		        'NewEventTime': $('#eventTime').val(),
		        'NewEventDuration': $('#eventDuration').val()
		    }
		    ClearPopupFormValues();
		    $.ajax({
		        type: 'POST',
		        url: "/Home/SaveEvent",
		        data: dataRow,
		        success: function (response) {
		            if (response == 'True') {
		                $('#calendar').fullCalendar('refetchEvents');
		                alert('New event saved!');
		            }
		            else {
		                alert('Error, could not save event!');
		            }
		        }
		    }); */
		    
		}); 
		
		var currentLangCode = 'ko';
		
		function renderCalendar() {
			$('#calendar').fullCalendar({
				eventClick: function(calEvent, jsEvent, view) {
				
			       alert('Event: ' + calEvent.title);
			       alert("allDay: " + calEvent.allDay);//종일 이벤트 인지 true/false
			       alert(new Date(calEvent.start) + "-" + new Date(calEvent.end));
			       //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
			       //alert('View: ' + view.name);
			
			       // change the border color just for fun
			       $(this).css('border-color', 'red');
				
				},
				/* selectable: true,
				selectHelper: true,
				select: function(start, end) {
					var title = prompt('Event 입력:');
					var eventData;
					if (title) {
						eventData = {
							title: title,
							start: start,
							end: end
						};
						$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
					}
					$('#calendar').fullCalendar('unselect');
				}, */
				dayClick: function(date, jsEvent, view) {

			        alert('Clicked on: ' + date.format());
			        
			        $('#eventTitle').val("");
			        //$('#eventDate').val($.fullCalendar.formatDate(date, 'dd/MM/yyyy'));
			        $('#eventDate').val('13/06/2016');
			        //$('#eventTime').val($.fullCalendar.formatDate(date, 'HH:mm'));
			        ShowEventPopup(date); 

			    },
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,basicWeek,basicDay'
				},
				defaultDate: '2016-05-12',
				lang: currentLangCode,
				timezone: 'local',//currentTimezone,//local, none, UTC
				editable: true,
				eventLimit: true, // allow "more" link when too many events
				events: [
					{
						title: 'All Day Event',
						start: '2016-05-01'
					},
					{
						title: 'Long Event',
						start: '2016-05-07',
						end: '2016-05-10'
					},
					{
						id: 999,
						title: 'Repeating Event',
						start: '2016-05-09T16:00:00'
					},
					{
						id: 999,
						title: 'Repeating Event',
						start: '2016-05-16T16:00:00'
					},
					{
						title: 'Conference',
						start: '2016-05-11',
						end: '2016-05-13'
					},
					{
						title: 'Meeting',
						start: '2016-05-12T10:30:00',
						end: '2016-05-12T12:30:00'
					},
					{
						title: 'Lunch',
						start: '2016-05-12T12:00:00'
					},
					{
						title: 'Meeting',
						start: '2016-05-12T14:30:00'
					},
					{
						title: 'Happy Hour',
						start: '2016-05-12T17:30:00'
					},
					{
						title: 'Dinner',
						start: '2016-05-12T20:00:00'
					},
					{
						title: 'Birthday Party',
						start: '2016-05-13T07:00:00'
					},
					{
						title: '구글 홈페이지',
						url: 'http://google.com/',
						start: '2016-05-28'
					}
				]
			});
		}
		renderCalendar();
	});

</script>
<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	
	#script-warning {
		display: none;
		background: #eee;
		border-bottom: 1px solid #ddd;
		padding: 0 10px;
		line-height: 40px;
		text-align: center;
		font-weight: bold;
		font-size: 12px;
		color: red;
	}

</style>
</head>
<body>
<!-- 	<div id='top'>
			Language:
			<select id='lang-selector'></select>
	</div>
	<div id='script-warning'>
		<code>php/get-events.php</code> must be running.
	</div> -->
	<div id='top'>

		<div class='left'>
			Timezone:
			<select id='timezone-selector'>
				<option value='' selected>none</option>
				<option value='local'>local</option>
				<option value='UTC'>UTC</option>
			</select>
		</div>

		<div class='right'>
			<span id='loading'>loading...</span>
			<span id='script-warning'><code>php/get-events.php</code> must be running.</span>
		</div>

		<div class='clear'></div>

	</div>

	<div id="popupEventForm" class="modal hide" style="display: none;">
		<div class="modal-header">
			<h3>Add new event</h3>
		</div>
		<div class="modal-body">
			<form id="EventForm" class="well">
				<input type="hidden" id="eventID"> <label>Event
					title</label> <input type="text" id="eventTitle" placeholder="Title here"><br />
				<label>Scheduled date</label> <input type="text" id="eventDate"><br />
				<label>Scheduled time</label> <input type="text" id="eventTime"><br />
				<label>Appointment length (minutes)</label> <input type="text"
					id="eventDuration" placeholder="15"><br />
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" id="btnPopupCancel" data-dismiss="modal"
				class="btn">Cancel</button>
			<button type="button" id="btnPopupSave" data-dismiss="modal"
				class="btn btn-primary">Save event</button>
		</div>
	</div>

	<div id='calendar'></div>
</body>
</html>