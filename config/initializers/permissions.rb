CREATE = 'create'.freeze
UPDATE = 'update'.freeze
READ = 'read'.freeze
LIST_VIEW = 'list_view'.freeze
DROPDOWN = 'dropdown'.freeze

USER_ABILITIES = {
  name: 'User',
  admin: {
    actions: %i[read list_view create update]
  },
  super_admin: {
    all: true
  },
  official: {
    actions: []
  },
  agent: {
    actions: []
  }
}.freeze

MANIFEST_ABILITIES = {
  name: 'Manifest',
  admin: {
    all: true
  },
  super_admin: {
    all: true
  },
  official: {
    actions: %i[read]
  },
  agent: {
    all: true
  }
}.freeze

COMPANY_ABILITIES = {
  name: 'Company',
  admin: {
    all: true
  },
  super_admin: {
    all: true
  },
  official: {
    actions: %i[read]
  },
  agent: {
    actions: %i[dropdown]
  }
}.freeze

TERMIMAL_ABILITIES = {
  name: 'Terminal',
  admin: {
    all: true
  },
  super_admin: {
    all: true
  },
  official: {
    actions: %i[read]
  },
  agent: {
    actions: %i[dropdown]
  }
}.freeze

PEOPLE_ABILITIES = {
  name: 'Person',
  admin: {
    all: true
  },
  super_admin: {
    all: true
  },
  official: {
    actions: %i[read]
  },
  agent: {
    all: true
  }
}.freeze

MOTOR_ABILITIES = {
  name: 'Motor',
  admin: {
    all: true
  },
  super_admin: {
    all: true
  },
  official: {
    actions: %i[read]
  },
  agent: {
    all: true
  }
}.freeze

ALL_ABILITIES = [
  MOTOR_ABILITIES, PEOPLE_ABILITIES, TERMIMAL_ABILITIES, TERMIMAL_ABILITIES, COMPANY_ABILITIES, MANIFEST_ABILITIES, USER_ABILITIES
].freeze
