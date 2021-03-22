# ui

Client的信号：

```cpp
signals:
    void version_checked(const QString &version_number, const QString &mod_name);
    void server_connected();
    void error_message(const QString &msg);
    void player_added(ClientPlayer *new_player);
    void player_removed(const QString &player_name);
    // choice signal
    void generals_got(const QStringList &generals);
    void kingdoms_got(const QStringList &kingdoms);
    void suits_got(const QStringList &suits);
    void options_got(const QString &skillName, const QStringList &options);
    void cards_got(const ClientPlayer *player, const QString &flags, const QString &reason, bool handcard_visible,
        Card::HandlingMethod method, QList<int> disabled_ids);
    void roles_got(const QString &scheme, const QStringList &roles);
    void directions_got();
    void orders_got(QSanProtocol::Game3v3ChooseOrderCommand reason);

    void seats_arranged(const QList<const ClientPlayer *> &seats);
    void hp_changed(const QString &who, int delta, DamageStruct::Nature nature, bool losthp);
    void maxhp_changed(const QString &who, int delta);
    void status_changed(Client::Status oldStatus, Client::Status newStatus);
    void avatars_hiden();
    void pile_reset();
    void player_killed(const QString &who);
    void player_revived(const QString &who);
    void card_shown(const QString &player_name, int card_id);
    void log_received(const QStringList &log_str);
    void guanxing(const QList<int> &card_ids, bool single_side);
    void gongxin(const QList<int> &card_ids, bool enable_heart, QList<int> enabled_ids);
    void focus_moved(const QStringList &focus, QSanProtocol::Countdown countdown);
    void emotion_set(const QString &target, const QString &emotion);
    void skill_invoked(const QString &who, const QString &skill_name);
    void skill_acquired(const ClientPlayer *player, const QString &skill_name);
    void animated(int name, const QStringList &args);
    void player_speak(const QString &who, const QString &text);
    void line_spoken(const QString &line);
    void card_used();

    void game_started();
    void game_over();
    void standoff();
    void event_received(const QVariant &);

    void move_cards_lost(int moveId, QList<CardsMoveStruct> moves);
    void move_cards_got(int moveId, QList<CardsMoveStruct> moves);

    void skill_attached(const QString &skill_name);
    void skill_detached(const QString &skill_name);
    void do_filter();

    void nullification_asked(bool asked);
    void surrender_enabled(bool enabled);

    void ag_filled(const QList<int> &card_ids, const QList<int> &disabled_ids);
    void ag_taken(ClientPlayer *taker, int card_id, bool move_cards);
    void ag_cleared();

    void generals_filled(const QStringList &general_names);
    void general_taken(const QString &who, const QString &name, const QString &rule);
    void general_asked();
    void arrange_started(const QString &to_arrange);
    void general_recovered(int index, const QString &name);
    void general_revealed(bool self, const QString &general);

    void role_state_changed(const QString &state_str);
    void generals_viewed(const QString &reason, const QStringList &names);

    void assign_asked();
    void start_in_xs();

    void skill_updated(const QString &skill_name);
```

RoomScene构造中的所有connection：

```cpp
RoomScene::RoomScene(QMainWindow *main_window)
    : main_window(main_window), game_started(false), m_tableBgPixmap(1, 1), m_tableBgPixmapOrig(1, 1)
{
    // ...

    // create table pile
    m_tablePile = new TablePile;
    addItem(m_tablePile);
    connect(ClientInstance, SIGNAL(card_used()), m_tablePile, SLOT(clear()));

    // create dashboard
    dashboard = new Dashboard(createDashboardButtons());
    dashboard->setObjectName("dashboard");
    dashboard->setZValue(0.8);
    addItem(dashboard);

    dashboard->setPlayer(Self);
    connect(Self, SIGNAL(general_changed()), dashboard, SLOT(updateAvatar()));
    connect(Self, SIGNAL(general2_changed()), dashboard, SLOT(updateSmallAvatar()));
    connect(dashboard, SIGNAL(card_selected(const Card *)), this, SLOT(enableTargets(const Card *)));
    connect(dashboard, SIGNAL(card_to_use()), this, SLOT(doOkButton()));
    //connect(dashboard, SIGNAL(add_equip_skill(const Skill *, bool)), this, SLOT(addSkillButton(const Skill *, bool)));
    //connect(dashboard, SIGNAL(remove_equip_skill(QString)), this, SLOT(detachSkill(QString)));

    connect(Self, SIGNAL(pile_changed(QString)), dashboard, SLOT(updatePile(QString)));

    // add role ComboBox
    connect(Self, SIGNAL(role_changed(QString)), dashboard, SLOT(updateRole(QString)));

    // ...

    miscellaneous_menu = new QMenu(main_window);

    change_general_menu = new QMenu(main_window);
    QAction *action = change_general_menu->addAction(tr("Change general ..."));
    FreeChooseDialog *general_changer = new FreeChooseDialog(main_window);
    connect(action, SIGNAL(triggered()), general_changer, SLOT(exec()));
    connect(general_changer, SIGNAL(general_chosen(QString)), this, SLOT(changeGeneral(QString)));
    to_change = NULL;

    m_add_robot_menu = new QMenu(main_window);

    // do signal-slot connections
    connect(ClientInstance, SIGNAL(player_added(ClientPlayer *)), SLOT(addPlayer(ClientPlayer *)));
    connect(ClientInstance, SIGNAL(player_removed(QString)), SLOT(removePlayer(QString)));
    connect(ClientInstance, SIGNAL(generals_got(QStringList)), this, SLOT(chooseGeneral(QStringList)));
    connect(ClientInstance, SIGNAL(generals_viewed(QString, QStringList)), this, SLOT(viewGenerals(QString, QStringList)));
    connect(ClientInstance, SIGNAL(suits_got(QStringList)), this, SLOT(chooseSuit(QStringList)));
    connect(ClientInstance, SIGNAL(options_got(QString, QStringList)), this, SLOT(chooseOption(QString, QStringList)));
    connect(ClientInstance, SIGNAL(cards_got(const ClientPlayer *, QString, QString, bool, Card::HandlingMethod, QList<int>)),
        this, SLOT(chooseCard(const ClientPlayer *, QString, QString, bool, Card::HandlingMethod, QList<int>)));
    connect(ClientInstance, SIGNAL(roles_got(QString, QStringList)), this, SLOT(chooseRole(QString, QStringList)));
    connect(ClientInstance, SIGNAL(directions_got()), this, SLOT(chooseDirection()));
    connect(ClientInstance, SIGNAL(orders_got(QSanProtocol::Game3v3ChooseOrderCommand)), this, SLOT(chooseOrder(QSanProtocol::Game3v3ChooseOrderCommand)));
    connect(ClientInstance, SIGNAL(kingdoms_got(QStringList)), this, SLOT(chooseKingdom(QStringList)));
    connect(ClientInstance, SIGNAL(seats_arranged(QList<const ClientPlayer *>)), SLOT(arrangeSeats(QList<const ClientPlayer *>)));
    connect(ClientInstance, SIGNAL(status_changed(Client::Status, Client::Status)), this, SLOT(updateStatus(Client::Status, Client::Status)));
    connect(ClientInstance, SIGNAL(avatars_hiden()), this, SLOT(hideAvatars()));
    connect(ClientInstance, SIGNAL(hp_changed(QString, int, DamageStruct::Nature, bool)), SLOT(changeHp(QString, int, DamageStruct::Nature, bool)));
    connect(ClientInstance, SIGNAL(maxhp_changed(QString, int)), SLOT(changeMaxHp(QString, int)));
    connect(ClientInstance, SIGNAL(pile_reset()), this, SLOT(resetPiles()));
    connect(ClientInstance, SIGNAL(player_killed(QString)), this, SLOT(killPlayer(QString)));
    connect(ClientInstance, SIGNAL(player_revived(QString)), this, SLOT(revivePlayer(QString)));
    connect(ClientInstance, SIGNAL(card_shown(QString, int)), this, SLOT(showCard(QString, int)));
    connect(ClientInstance, SIGNAL(gongxin(QList<int>, bool, QList<int>)), this, SLOT(doGongxin(QList<int>, bool, QList<int>)));
    connect(ClientInstance, SIGNAL(focus_moved(QStringList, QSanProtocol::Countdown)), this, SLOT(moveFocus(QStringList, QSanProtocol::Countdown)));
    connect(ClientInstance, SIGNAL(emotion_set(QString, QString)), this, SLOT(setEmotion(QString, QString)));
    connect(ClientInstance, SIGNAL(skill_invoked(QString, QString)), this, SLOT(showSkillInvocation(QString, QString)));
    connect(ClientInstance, SIGNAL(skill_acquired(const ClientPlayer *, QString)), this, SLOT(acquireSkill(const ClientPlayer *, QString)));
    connect(ClientInstance, SIGNAL(animated(int, QStringList)), this, SLOT(doAnimation(int, QStringList)));
    connect(ClientInstance, SIGNAL(role_state_changed(QString)), this, SLOT(updateRoles(QString)));
    connect(ClientInstance, SIGNAL(event_received(const QVariant)), this, SLOT(handleGameEvent(const QVariant)));

    connect(ClientInstance, SIGNAL(game_started()), this, SLOT(onGameStart()));
    connect(ClientInstance, SIGNAL(game_over()), this, SLOT(onGameOver()));
    connect(ClientInstance, SIGNAL(standoff()), this, SLOT(onStandoff()));

    connect(ClientInstance, SIGNAL(move_cards_lost(int, QList<CardsMoveStruct>)), this, SLOT(loseCards(int, QList<CardsMoveStruct>)));
    connect(ClientInstance, SIGNAL(move_cards_got(int, QList<CardsMoveStruct>)), this, SLOT(getCards(int, QList<CardsMoveStruct>)));

    connect(ClientInstance, SIGNAL(nullification_asked(bool)), dashboard, SLOT(controlNullificationButton(bool)));

    connect(ClientInstance, SIGNAL(assign_asked()), this, SLOT(startAssign()));
    connect(ClientInstance, SIGNAL(start_in_xs()), this, SLOT(startInXs()));

    connect(ClientInstance, &Client::skill_updated, this, &RoomScene::updateSkill);

    guanxing_box = new GuanxingBox;
    
    // ...

    connect(ClientInstance, SIGNAL(guanxing(QList<int>, bool)), guanxing_box, SLOT(doGuanxing(QList<int>, bool)));
    guanxing_box->moveBy(-120, 0);

    card_container = new CardContainer();
    
    // ...

    connect(card_container, SIGNAL(item_chosen(int)), ClientInstance, SLOT(onPlayerChooseAG(int)));
    connect(card_container, SIGNAL(item_gongxined(int)), ClientInstance, SLOT(onPlayerReplyGongxin(int)));

    connect(ClientInstance, SIGNAL(ag_filled(QList<int>, QList<int>)), this, SLOT(fillCards(QList<int>, QList<int>)));
    connect(ClientInstance, SIGNAL(ag_taken(ClientPlayer *, int, bool)), this, SLOT(takeAmazingGrace(ClientPlayer *, int, bool)));
    connect(ClientInstance, SIGNAL(ag_cleared()), card_container, SLOT(clear()));

    card_container->moveBy(-120, 0);

    connect(ClientInstance, SIGNAL(skill_attached(QString)), this, SLOT(attachSkill(QString)));
    connect(ClientInstance, SIGNAL(skill_detached(QString)), this, SLOT(detachSkill(QString)));

    // ...

    // chat box
    // ...
    connect(ClientInstance, SIGNAL(line_spoken(QString)), chat_box, SLOT(append(QString)));
    connect(ClientInstance, SIGNAL(player_speak(const QString &, const QString &)),
        this, SLOT(showBubbleChatBox(const QString &, const QString &)));

    // chat edit
    // ...
    connect(chat_edit, SIGNAL(returnPressed()), this, SLOT(speak()));
    chat_edit->setPlaceholderText(tr("Please enter text to chat ... "));

    chat_widget = new ChatWidget();
    chat_widget->setZValue(-0.1);
    addItem(chat_widget);
    connect(chat_widget, SIGNAL(return_button_click()), this, SLOT(speak()));
    connect(chat_widget, SIGNAL(chat_widget_msg(QString)), this, SLOT(appendChatEdit(QString)));

    if (ServerInfo.DisableChat)
        chat_edit_widget->hide();

    // log box
    // ...
    connect(ClientInstance, SIGNAL(log_received(QStringList)), log_box, SLOT(appendLog(QStringList)));

    // ...
    if (ServerInfo.EnableAI) {
        // ...

        connect(add_robot, SIGNAL(clicked()), this, SLOT(addRobot()));
        connect(start_game, SIGNAL(clicked()), this, SLOT(fillRobots()));
        connect(Self, SIGNAL(owner_changed(bool)), this, SLOT(showOwnerButtons(bool)));
    }

    return_to_main_menu = new Button(tr("Return to main menu"));
    // ...

    connect(return_to_main_menu, SIGNAL(clicked()), this, SIGNAL(return_to_start()));
    // ...
}
```

```cpp
class RoomScene : public QGraphicsScene
{
    Q_OBJECT

public:
    enum ShefuAskState
    {
        ShefuAskAll, ShefuAskNecessary, ShefuAskNone
    };

    RoomScene(QMainWindow *main_window);
    ~RoomScene();
    void changeTextEditBackground();
    void adjustItems();
    void showIndicator(const QString &from, const QString &to);
    void showPromptBox();
    static void FillPlayerNames(QComboBox *ComboBox, bool add_none);
    void updateTable();
    void updateVolumeConfig();
    void redrawDashboardButtons();
    inline QMainWindow *mainWindow()
    {
        return main_window;
    }

    inline bool isCancelButtonEnabled() const
    {
        return cancel_button != NULL && cancel_button->isEnabled();
    }
    inline void setGuhuoLog(const QString &log)
    {
        guhuo_log = log;
    }

    bool m_skillButtonSank;
    ShefuAskState m_ShefuAskState;

public slots:
    void addPlayer(ClientPlayer *player);
    void removePlayer(const QString &player_name);
    void loseCards(int moveId, QList<CardsMoveStruct> moves);
    void getCards(int moveId, QList<CardsMoveStruct> moves);
    void keepLoseCardLog(const CardsMoveStruct &move);
    void keepGetCardLog(const CardsMoveStruct &move);
    // choice dialog
    void chooseGeneral(const QStringList &generals);
    void chooseSuit(const QStringList &suits);
    void chooseCard(const ClientPlayer *playerName, const QString &flags, const QString &reason,
        bool handcard_visible, Card::HandlingMethod method, QList<int> disabled_ids);
    void chooseKingdom(const QStringList &kingdoms);
    void chooseOption(const QString &skillName, const QStringList &options);
    void chooseOrder(QSanProtocol::Game3v3ChooseOrderCommand reason);
    void chooseRole(const QString &scheme, const QStringList &roles);
    void chooseDirection();

    void bringToFront(QGraphicsItem *item);
    void arrangeSeats(const QList<const ClientPlayer *> &seats);
    void toggleDiscards();
    void enableTargets(const Card *card);
    void useSelectedCard();
    void updateStatus(Client::Status oldStatus, Client::Status newStatus);
    void killPlayer(const QString &who);
    void revivePlayer(const QString &who);
    void showServerInformation();
    void surrender();
    void saveReplayRecord();
    void makeDamage();
    void makeKilling();
    void makeReviving();
    void doScript();
    void viewGenerals(const QString &reason, const QStringList &names);

    void handleGameEvent(const QVariant &arg);

    void doOkButton();
    void doCancelButton();
    void doDiscardButton();

    void setChatBoxVisibleSlot();
    void pause();

    void addRobot();
    void doAddRobotAction();
    void fillRobots();

protected:
    virtual void mousePressEvent(QGraphicsSceneMouseEvent *event);
    virtual void mouseMoveEvent(QGraphicsSceneMouseEvent *event);
    virtual void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    virtual void keyReleaseEvent(QKeyEvent *event);
    //this method causes crashes
    virtual void contextMenuEvent(QGraphicsSceneContextMenuEvent *event);
    QMutex m_roomMutex;
    QMutex m_zValueMutex;

private:
    void _getSceneSizes(QSize &minSize, QSize &maxSize);
    bool _shouldIgnoreDisplayMove(CardsMoveStruct &movement);
    bool _processCardsMove(CardsMoveStruct &move, bool isLost);
    bool _m_isInDragAndUseMode;
    bool _m_superDragStarted;
    const QSanRoomSkin::RoomLayout *_m_roomLayout;
    const QSanRoomSkin::PhotoLayout *_m_photoLayout;
    const QSanRoomSkin::CommonLayout *_m_commonLayout;
    const QSanRoomSkin* _m_roomSkin;
    QGraphicsItem *_m_last_front_item;
    double _m_last_front_ZValue;
    GenericCardContainer *_getGenericCardContainer(Player::Place place, Player *player);
    QMap<int, QList<QList<CardItem *> > > _m_cardsMoveStash;
    Button *add_robot, *start_game, *return_to_main_menu;
    QList<Photo *> photos;
    QMap<QString, Photo *> name2photo;
    Dashboard *dashboard;
    TablePile *m_tablePile;
    QMainWindow *main_window;
    QSanButton *ok_button, *cancel_button, *discard_button;
    QSanButton *trust_button;
    QMenu *miscellaneous_menu, *change_general_menu;
    Window *prompt_box;
    Window *pindian_box;
    CardItem *pindian_from_card, *pindian_to_card;
    QGraphicsItem *control_panel;
    QMap<PlayerCardContainer *, const ClientPlayer *> item2player;
    QDialog *m_choiceDialog; // Dialog for choosing generals, suits, card/equip, or kingdoms

    QGraphicsRectItem *pausing_item;
    QGraphicsSimpleTextItem *pausing_text;

    QString guhuo_log;

    QList<QGraphicsPixmapItem *> role_items;
    CardContainer *card_container;

    QList<QSanSkillButton *> m_skillButtons;

    ResponseSkill *response_skill;
    ShowOrPindianSkill *showorpindian_skill;
    DiscardSkill *discard_skill;
    NosYijiViewAsSkill *yiji_skill;
    ChoosePlayerSkill *choose_skill;

    QList<const Player *> selected_targets;

    GuanxingBox *guanxing_box;

    QList<CardItem *> gongxin_items;

    ClientLogBox *log_box;
    QTextEdit *chat_box;
    QLineEdit *chat_edit;
    QGraphicsProxyWidget *chat_box_widget;
    QGraphicsProxyWidget *log_box_widget;
    QGraphicsProxyWidget *chat_edit_widget;
    QGraphicsTextItem *prompt_box_widget;
    ChatWidget *chat_widget;
    QPixmap m_rolesBoxBackground;
    QGraphicsPixmapItem *m_rolesBox;
    QGraphicsTextItem *m_pileCardNumInfoTextBox;

    QGraphicsPixmapItem *m_tableBg;
    QPixmap m_tableBgPixmap;
    QPixmap m_tableBgPixmapOrig;
    int m_tablew;
    int m_tableh;

    QMenu *m_add_robot_menu;

    QMap<QString, BubbleChatBox *> bubbleChatBoxes;

    // for 3v3 & 1v1 mode
    QSanSelectableItem *selector_box;
    QList<CardItem *> general_items, up_generals, down_generals;
    CardItem *to_change;
    QList<QGraphicsRectItem *> arrange_rects;
    QList<CardItem *> arrange_items;
    Button *arrange_button;
    KOFOrderBox *enemy_box, *self_box;
    QPointF m_tableCenterPos;
    ReplayerControlBar *m_replayControl;

    struct _MoveCardsClassifier
    {
        inline _MoveCardsClassifier(const CardsMoveStruct &move)
        {
            m_card_ids = move.card_ids;
        }
        inline bool operator ==(const _MoveCardsClassifier &other) const
        {
            return m_card_ids == other.m_card_ids;
        }
        inline bool operator <(const _MoveCardsClassifier &other) const
        {
            return m_card_ids.first() < other.m_card_ids.first();
        }
        QList<int> m_card_ids;
    };

    QMap<_MoveCardsClassifier, CardsMoveStruct> m_move_cache;

    // @todo: this function shouldn't be here. But it's here anyway, before someone find a better
    // home for it.
    QString _translateMovement(const CardsMoveStruct &move);

    void useCard(const Card *card);
    void fillTable(QTableWidget *table, const QList<const ClientPlayer *> &players);
    void chooseSkillButton();

    void selectTarget(int order, bool multiple);
    void selectNextTarget(bool multiple);
    void unselectAllTargets(const QGraphicsItem *except = NULL);
    void updateTargetsEnablity(const Card *card = NULL);

    void callViewAsSkill();
    void cancelViewAsSkill();

    void freeze();
    void addRestartButton(QDialog *dialog);
    QGraphicsPixmapItem *createDashboardButtons();
    void createReplayControlBar();

    void fillGenerals1v1(const QStringList &names);
    void fillGenerals3v3(const QStringList &names);

    void showPindianBox(const QString &from_name, int from_id, const QString &to_name, int to_id, const QString &reason);
    void setChatBoxVisible(bool show);
    QRect getBubbleChatBoxShowArea(const QString &who) const;

    // animation related functions
    typedef void (RoomScene::*AnimationFunc)(const QString &, const QStringList &);
    QGraphicsObject *getAnimationObject(const QString &name) const;

    void doMovingAnimation(const QString &name, const QStringList &args);
    void doAppearingAnimation(const QString &name, const QStringList &args);
    void doLightboxAnimation(const QString &name, const QStringList &args);
    void doHuashen(const QString &name, const QStringList &args);
    void doIndicate(const QString &name, const QStringList &args);
    EffectAnimation *animations;
    bool pindian_success;

    // re-layout attempts
    bool game_started;
    void _dispersePhotos(QList<Photo *> &photos, QRectF disperseRegion, Qt::Orientation orientation, Qt::Alignment align);

    void _cancelAllFocus();
    // for miniscenes
    int _m_currentStage;

    QRectF _m_infoPlane;

    bool _m_bgEnabled;
    QString _m_bgMusicPath;

    void recorderAutoSave();

#ifndef Q_OS_WINRT
    // for animation effects
    QQmlEngine *_m_animationEngine;
    QQmlContext *_m_animationContext;
    QQmlComponent *_m_animationComponent;
#endif

private slots:
    void fillCards(const QList<int> &card_ids, const QList<int> &disabled_ids = QList<int>());
    void updateSkillButtons(bool isPrepare = false);
    void acquireSkill(const ClientPlayer *player, const QString &skill_name);
    void updateSelectedTargets();
    void updateTrustButton();
    void onSkillActivated();
    void onSkillDeactivated();
    void doTimeout();
    void startInXs();
    void hideAvatars();
    void changeHp(const QString &who, int delta, DamageStruct::Nature nature, bool losthp);
    void changeMaxHp(const QString &who, int delta);
    void moveFocus(const QStringList &who, QSanProtocol::Countdown);
    void setEmotion(const QString &who, const QString &emotion);
    void showSkillInvocation(const QString &who, const QString &skill_name);
    void doAnimation(int name, const QStringList &args);
    void showOwnerButtons(bool owner);
    void showPlayerCards();
    void updateRolesBox();
    void updateRoles(const QString &roles);
    void addSkillButton(const Skill *skill);

    void resetPiles();
    void removeLightBox();

    void showCard(const QString &player_name, int card_id);
    void viewDistance();

    void speak();

    void onGameStart();
    void onGameOver();
    void onStandoff();

    void appendChatEdit(QString txt);
    void showBubbleChatBox(const QString &who, const QString &words);

    //animations
    void onEnabledChange();

    void takeAmazingGrace(ClientPlayer *taker, int card_id, bool move_cards);

    void attachSkill(const QString &skill_name);
    void detachSkill(const QString &skill_name);
    void updateSkill(const QString &skill_name);

    void doGongxin(const QList<int> &card_ids, bool enable_heart, QList<int> enabled_ids);

    void startAssign();

    void doPindianAnimation();

    // 3v3 mode & 1v1 mode
    void fillGenerals(const QStringList &names);
    void takeGeneral(const QString &who, const QString &name, const QString &rule);
    void recoverGeneral(int index, const QString &name);
    void startGeneralSelection();
    void selectGeneral();
    void startArrange(const QString &to_arrange);
    void toggleArrange();
    void finishArrange();
    void changeGeneral(const QString &general);
    void revealGeneral(bool self, const QString &general);
    void trust();

signals:
    void restart();
    void return_to_start();
    void game_over_dialog_rejected();
};
```
