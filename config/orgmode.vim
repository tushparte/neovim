" Org-mode config
lua << EOF
require('orgmode').setup({
  org_agenda_files = '~/Documents/org-notes/**/*',
  org_default_notes_file = '~/Documents/org-notes/agenda.org',
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n  SCHEDULED: %t',
      target = '~/Documents/org-notes/agenda.org',
    },
    m = {
      description = 'Meeting note',
      template = '* %? :meeting:\n  %U\n',
      target = '~/Documents/org-notes/agenda.org',
    },
    j = {
      description = 'Journal entry',
      template = '* %U %?',
      target = '~/Documents/org-notes/journal.org',
    },
  },
})
EOF
